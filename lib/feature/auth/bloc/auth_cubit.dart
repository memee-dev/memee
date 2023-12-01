import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:memee/core/utils/app_di.dart';
import 'package:memee/core/utils/app_firestore.dart';
import 'package:memee/feature/auth/repo/user_repo.dart';

enum AuthState {
  splash,
  authenticated,
  unauthenticated,
}

class AuthCubit extends Cubit<AuthState> {
  final auth = locator.get<FirebaseAuth>();
  final db = locator.get<FirebaseFirestore>();
  final userRepo = locator.get<UserRepo>();

  AuthCubit() : super(AuthState.splash);

  Future<void> checkAuthenticationStatus() async {
    await Future.delayed(const Duration(seconds: 2));
    auth.authStateChanges().listen((User? user) async {
      try {
        if (user != null) {
          userRepo.user = user;
          DocumentSnapshot userDoc = await db
              .collection(AppFireStoreCollection.userDev)
              .doc(user.uid)
              .get();
          if (userDoc.exists) {
            userDoc.data();
            emit(AuthState.authenticated);
          } else {
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
