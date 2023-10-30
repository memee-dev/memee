import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';

enum AuthStatus { loading, authenticated, unauthenticated }

class AuthCubit extends Cubit<AuthStatus> {
  final FirebaseAuth auth;

  AuthCubit(this.auth) : super(AuthStatus.loading);

  Future<void> checkAuthenticationStatus() async {
    await Future.delayed(const Duration(seconds: 2));
    auth.authStateChanges().listen((User? user) {
      if (user != null) {
        emit(AuthStatus.authenticated);
      } else {
        emit(AuthStatus.unauthenticated);
      }
    });
  }
}
