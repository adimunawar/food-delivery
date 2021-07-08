part of 'models.dart';

class CartModel extends Equatable {
  final int id;
  final Food food;
  final User user;
  final String quantity;

  CartModel({this.id, this.food, this.quantity, this.user});
  @override
  List<Object> get props => [id, quantity, user, food];

  CartModel copyWith([
    int id,
    Food food,
    User user,
    String quantity,
  ]) {
    return CartModel(
        id: id ?? this.id,
        food: food ?? this.food,
        user: user ?? this.user,
        quantity: quantity ?? this.quantity);
  }

  factory CartModel.fromJson(Map<String, dynamic> data) => CartModel(
        id: data['id'],
        food: Food.fromJson(data['food']),
        quantity: data['quantity'].toString(),
      );
}
