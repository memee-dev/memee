part of 'cart_cubit.dart';

abstract class CartState extends Equatable {
  @override
  List<Object> get props => [];
}

abstract class CartResponseState extends CartState {
  final List<CartModel> cartItems;

  CartResponseState(this.cartItems);

  @override
  List<Object> get props => [];
}

class CartLoading extends CartState {}

class CartSuccess extends CartResponseState {
  CartSuccess({required List<CartModel> cartItems}) : super(cartItems);
}

class CartFailure extends CartResponseState {
  final String message;

  CartFailure({required this.message, required List<CartModel> cartItems})
      : super(cartItems);
}
