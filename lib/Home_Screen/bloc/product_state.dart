part of 'product_bloc.dart';

abstract class ProductState extends Equatable {
  const ProductState();

  @override
  List<Object> get props => [];
}

class ProductInitial extends ProductState {}

class ProductLoading extends ProductState {}

class ProductLoaded extends ProductState {
  const ProductLoaded({required this.products});
  final List<Product> products;

  @override
  List<Object> get props => [products];
}

class ProductEmpty extends ProductState {}

class ProductError extends ProductState {
  const ProductError({required this.errorMessage});
  final String errorMessage;
}
