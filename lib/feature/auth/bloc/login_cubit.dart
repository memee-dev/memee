import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:memee/core/utils/app_di.dart';
import 'package:memee/core/utils/app_firestore.dart';
import 'package:memee/core/utils/app_logger.dart';
import 'package:memee/feature/auth/bloc/auth_cubit.dart';
import 'package:memee/models/user_model.dart';

enum LoginState {
  phoneNumber,
  otp,
  register,
}

class LoginCubit extends Cubit<LoginState> {
  final auth = locator.get<FirebaseAuth>();
  final db = locator.get<FirebaseFirestore>();

  String? phoneNumber;
  String? verificationId;
  int? resendToken;

  User? user;
  late UserModel? loginUser;

  LoginCubit() : super(LoginState.phoneNumber);

  Future<void> verifyPhoneNumber(String phoneNumber) async {
    try {
      this.phoneNumber = phoneNumber;
      await auth.verifyPhoneNumber(
        phoneNumber: phoneNumber,
        verificationCompleted: (PhoneAuthCredential credential) async {
          console.i('verificationCompleted: $credential');
        },
        verificationFailed: (FirebaseAuthException e) {
          console.e('verificationCompleted', error: e.toString());
        },
        codeSent: (String? verificationId, int? resendToken) {
          this.verificationId = verificationId;
          this.resendToken = resendToken;
          emit(LoginState.otp);
        },
        codeAutoRetrievalTimeout: (String verificationId) {
          this.verificationId = verificationId;
          emit(LoginState.otp);
        },
      );
    } catch (e) {
      console.e(e);
    }
  }

  Future<void> verifyOTP(String otp) async {
    try {
      final credential = PhoneAuthProvider.credential(
        verificationId: verificationId ?? '',
        smsCode: otp,
      );
      UserCredential userCredential =
          await auth.signInWithCredential(credential);
      user = userCredential.user;
      if (user != null) {
        DocumentSnapshot userDoc = await db
            .collection(AppFireStoreCollection.userDev)
            .doc(user!.uid)
            .get();

        if (userDoc.exists) {
          loginUser =
              UserModel.fromJson(userDoc.data() as Map<String, dynamic>);
        } else {
          emit(LoginState.register);
        }
      } else {
        auth.signOut();
        emit(LoginState.phoneNumber);
      }
    } catch (e) {
      console.e(e);
    }
  }

  Future<void> register(String name, String email) async {
    if (user != null && phoneNumber != null) {
      loginUser = UserModel(
        id: user!.uid,
        phoneNumber: phoneNumber!,
        userName: name,
        email: email,
      );
      await db
          .collection(AppFireStoreCollection.userDev)
          .doc(user!.uid)
          .set(loginUser!.toJson());
      locator.get<AuthCubit>().checkAuthenticationStatus();
    }
  }

  void back() {
    int backIndex = state.index - 1;
    if (backIndex > -1) {
      emit(LoginState.values[backIndex]);
    }
  }
}
