part of 'cart_bloc.dart';

abstract class CartEvent extends Equatable {
  const CartEvent();

  @override
  List<Object> get props => [];
}

class AddToCart extends CartEvent {
  final CartModel productCart;

  AddToCart({this.productCart});

  @override
  List<Object> get props => [productCart];
}

class RemoveCart extends CartEvent {
  final CartModel productCart;

  RemoveCart({this.productCart});

  @override
  List<Object> get props => [productCart];
}

class GetCart extends CartEvent {
  @override
  List<Object> get props => [];
}
