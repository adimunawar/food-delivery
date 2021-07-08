part of 'cart_bloc.dart';

abstract class CartBlocState extends Equatable {
  const CartBlocState();

  @override
  List<Object> get props => [];
}

class CartInitial extends CartBlocState {}

class CartLoaded extends CartBlocState {
  final List<CartModel> productCart;

  CartLoaded(this.productCart);

  @override
  List<Object> get props => [productCart];
}

class GetCartLoading extends CartBlocState {
  @override
  List<Object> get props => [];
}

class CartLoadingFailed extends CartBlocState {
  final String message;
  CartLoadingFailed(this.message);

  @override
  List<Object> get props => [message];
}
