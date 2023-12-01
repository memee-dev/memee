import 'package:equatable/equatable.dart';

sealed class LoginState extends Equatable {
  const LoginState();

  @override
  List<Object> get props => [];
}

final class LoginInitial extends LoginState {}

final class LoginLoading extends LoginState {}

final class LoginLoading2 extends LoginState {}

final class LoginSuccess extends LoginState {
  final String? message;

  const LoginSuccess({this.message});
}

final class OtpSuccess extends LoginState {
  final String? message;
  final String? otp;
  final String? verificationId;

  const OtpSuccess({
    this.message,
    this.verificationId,
    this.otp,
  });
}

final class LoginFailure extends LoginState {
  final String message;

  const LoginFailure({required this.message});
}
