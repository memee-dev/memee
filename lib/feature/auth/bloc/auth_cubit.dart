import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:memee/core/utils/app_firestore.dart';

enum AuthState {
  splash,
  authenticated,
  unauthenticated,
  register,
}

class AuthCubit extends Cubit<AuthState> {
  final FirebaseAuth auth;
  final FirebaseFirestore db;

  AuthCubit(this.auth, this.db) : super(AuthState.splash);

  Future<void> checkAuthenticationStatus() async {
    await Future.delayed(const Duration(seconds: 2));
    auth.authStateChanges().listen((User? user) async {
      try {
        if (user != null) {
          DocumentSnapshot userDoc = await db
              .collection(AppFireStoreCollection.userDev)
              .doc(user.uid)
              .get();
          if (userDoc.exists) {
            emit(AuthState.authenticated);
          } else {
            await user.delete();
            emit(AuthState.unauthenticated);
          }
        } else {
          emit(AuthState.unauthenticated);
        }
      } catch (e) {
        emit(AuthState.unauthenticated);
      }
    });
  }

  void reset() {
    auth.signOut();
  }
}
