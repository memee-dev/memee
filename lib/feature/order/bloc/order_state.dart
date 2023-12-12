part of 'order_cubit.dart';

abstract class OrderState extends Equatable {
  @override
  List<Object> get props => [];
}

class OrderInitial extends OrderState {}
class OrderLoading extends OrderState {}

class OrderSuccess extends OrderState {
  final bool? updated;
  final List<OrderModel> orders;

  OrderSuccess({
    required this.orders,
    this.updated = false,
  });
}

class OrderFailure extends OrderState {}
