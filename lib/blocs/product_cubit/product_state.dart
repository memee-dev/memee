part of 'product_cubit.dart';

sealed class ProductState extends Equatable {
  const ProductState();

  @override
  List<Object> get props => [];
}

final class ProductInitial extends ProductState {}

final class ProductLoading extends ProductState {}

final class ProductSuccess extends ProductState {
  final List<ProductEntity> products;

  const ProductSuccess({required this.products});
}

final class ProductFailure extends ProductState {
  final String message;

  const ProductFailure({required this.message});
}
