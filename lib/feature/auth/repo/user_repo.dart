import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:memee/models/user_model.dart';

// ignore: must_be_immutable
class UserRepo extends Equatable {
  User? user;
  UserModel? userModel;

  UserRepo();

  @override
  List<Object?> get props => [user, userModel];

  clear() {
    user = null;
    userModel = null;
  }
}
