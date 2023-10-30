import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// Define the states for the login process.
enum LoginStatus { initial, loading, success, failure }

class LoginCubit extends Cubit<LoginStatus> {
  final FirebaseAuth auth;
  LoginCubit(this.auth) : super(LoginStatus.initial);

  // This method is used to initiate the login process.
  Future<void> loginWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    emit(LoginStatus.loading);

    try {
      await auth.signInWithEmailAndPassword(email: email, password: password);
      emit(LoginStatus.success);
    } catch (e) {
      emit(LoginStatus.failure);
    }
  }

  // Reset the state to the initial state.
  void reset() {
    auth.signOut();
    emit(LoginStatus.initial);
  }
}
