part of 'payment_cubit.dart';

abstract class PaymentState extends Equatable {
  @override
  List<Object> get props => [];
}

class PaymentInitial extends PaymentState {}

class PaymentSuccess extends PaymentState {
  final String paymentId;

  PaymentSuccess({required this.paymentId});
}

class PaymentFailure extends PaymentState {
  final PaymentFailureResponse response;

  PaymentFailure({required this.response});
}

class PaymentWalletFailure extends PaymentState {
  final String message;

  PaymentWalletFailure({required this.message});
}
