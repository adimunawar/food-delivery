part of 'cart_cubit.dart';

abstract class CartState extends Equatable {
  const CartState();

  @override
  List<Object> get props => [];
}

class CartInitial extends CartState {}

class CartCubitLoaded extends CartState {
  final List<CartModel> productCart;

  CartCubitLoaded(this.productCart);

  @override
  List<Object> get props => [productCart];
}

class GetCubitCartLoading extends CartState {
  @override
  List<Object> get props => [];
}

class CartCubitLoadingFailed extends CartState {
  final String message;
  CartCubitLoadingFailed(this.message);

  @override
  List<Object> get props => [message];
}
