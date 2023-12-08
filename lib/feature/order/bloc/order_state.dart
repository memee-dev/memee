part of 'order_cubit.dart';

abstract class OrderState extends Equatable {
  @override
  List<Object> get props => [];
}

class OrderInitial extends OrderState {}

class OrderSuccess extends OrderState {
  final List<OrderModel> orders;

  OrderSuccess({required this.orders});
}

class OrderFailure extends OrderState {}
