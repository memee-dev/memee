import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:memee/blocs/login/login_state.dart';
import 'package:memee/core/shared/app_firestore.dart';
import 'package:memee/core/shared/app_logger.dart';
import 'package:memee/models/user_model.dart';

class LoginCubit extends Cubit<LoginState> {
  final FirebaseAuth auth;
  final FirebaseFirestore db;

  late UserModel loginUser;

  LoginCubit(this.auth, this.db) : super(LoginInitial());

  // This method is used to initiate the login process.
  Future<void> loginWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    emit(LoginLoading());
    try {
      await auth.signInWithEmailAndPassword(email: email, password: password);
      emit(const LoginSuccess());
    } catch (e) {
      emit(LoginFailure(message: e.toString()));
    }
  }

  Future<void> loginWithPhoneNumber({
    required String otp,
    String? verificationId,
  }) async {
    emit(LoginLoading2());

    try {
      PhoneAuthCredential credential = PhoneAuthProvider.credential(
        verificationId: verificationId ?? '',
        smsCode: otp,
      );
      UserCredential userCredential =
          await auth.signInWithCredential(credential);
      User? user = userCredential.user;
      if (user != null) {
        DocumentSnapshot userDoc = await db
            .collection(AppFireStoreCollection.userDev)
            .doc(user.uid)
            .get();


        if (userDoc.exists) {
          loginUser =
              UserModel.fromJson(userDoc.data() as Map<String, dynamic>);
        } else {
          loginUser = UserModel.fromJson({
            'userName': '',
            'email': '',
            'id': user.uid,
            'verified': false,
            'address': [],
            'active': false,
            'phoneNumber': user.phoneNumber
          });


          await db
              .collection(AppFireStoreCollection.userDev)
              .doc(user.uid)
              .set(loginUser.toJson());
        }

        emit(const LoginSuccess(message: 'Successfully logged in'));
      } else {
        auth.signOut();
        emit(const LoginFailure(message: 'Failed to login, please try again'));
      }
    } catch (e) {
      log.e(e);
    }
  }

  Future<void> verifyPhoneNumber(String phoneNumber) async {
    emit(LoginLoading());
    try {
      await auth.verifyPhoneNumber(
        phoneNumber: phoneNumber,
        verificationCompleted: (PhoneAuthCredential credential) async {},
        verificationFailed: (FirebaseAuthException e) {
          emit(LoginFailure(message: e.message ?? 'Verification Failed'));
        },
        codeSent: (String? verificationId, int? resendToken) {
          emit(OtpSuccess(
            message: 'Otp sent your registered mobile number',
            verificationId: verificationId ?? '',
          ));
        },
        codeAutoRetrievalTimeout: (String verificationId) {
          emit(OtpSuccess(verificationId: verificationId));
        },
      );
    } catch (e) {
      log.e(e);
    }
  }

  // Reset the state to the initial state.
  void reset() {
    auth.signOut();
    emit(LoginInitial());
  }

  Future<void> setOtp(String otp) async {
    emit(OtpSuccess(otp: otp));
  }
}
