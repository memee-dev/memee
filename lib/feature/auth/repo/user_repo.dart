import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';

// ignore: must_be_immutable
class UserRepo extends Equatable {
  late User? user;

  UserRepo();

  @override
  List<Object?> get props => [user];
}
