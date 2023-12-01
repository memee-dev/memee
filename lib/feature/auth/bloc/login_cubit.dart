import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:memee/core/utils/app_di.dart';
import 'package:memee/core/utils/app_firestore.dart';
import 'package:memee/core/utils/app_logger.dart';
import 'package:memee/feature/auth/bloc/auth_cubit.dart';
import 'package:memee/models/user_model.dart';

import '../repo/user_repo.dart';

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

  LoginCubit() : super(LoginState.phoneNumber);

  Future<void> checkAuthIsDone() async {
    final userRepo = locator.get<UserRepo>();
    if (userRepo.user != null) {
      if (userRepo.userModel == null) {
        emit(LoginState.register);
      }
    }
  }

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
      await auth.signInWithCredential(credential);
      final userRepo = locator.get<UserRepo>();
      if (userRepo.user != null) {
        if (userRepo.userModel == null) {
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
    final userRepo = locator.get<UserRepo>();
    if (userRepo.user != null && phoneNumber != null) {
      userRepo.userModel = UserModel(
        id: userRepo.user!.uid,
        phoneNumber: phoneNumber!,
        userName: name,
        email: email,
      );
      await db
          .collection(AppFireStoreCollection.userDev)
          .doc(userRepo.user!.uid)
          .set(userRepo.userModel!.toJson());
      locator.get<AuthCubit>().checkAuthenticationStatus();
    }
  }

  void back() {
    int backIndex = state.index - 1;
    if (backIndex > -1) {
      emit(LoginState.values[backIndex]);
      if (backIndex == 0) {
        locator.get<AuthCubit>().reset();
      }
    }
  }
}
