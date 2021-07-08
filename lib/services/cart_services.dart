part of 'services.dart';

class CartServices {
  static Future<ApiReturnValue<List<CartModel>>> getCart(
      {http.Client client}) async {
    if (client == null) {
      client = http.Client();
    }

    String url = baseUrl + 'getcart';
    var response = await client.get(url, headers: {
      "Content-Type": "application/json",
      "Authorization": "Bearer ${User.token}"
    });
    if (response.statusCode != 200) {
      return ApiReturnValue(message: 'please try again');
    }

    var data = jsonDecode(response.body);

    List<CartModel> cart = (data['data']['data'] as Iterable)
        .map((e) => CartModel.fromJson(e))
        .toList();
    // int index = cart.indexWhere((i) => i.id == id);
    // var int id_food = transaction.where((element) => element.id);
    return ApiReturnValue(value: cart);
  }

  static Future<ApiReturnValue<List<CartModel>>> submitCart(CartModel cart,
      {http.Client client}) async {
    client ??= http.Client();

    String url = baseUrl + 'addcart';

    var response = await client.post(url,
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer ${User.token}"
        },
        body: jsonEncode(<String, dynamic>{
          'food_id': cart.food.id,
          'user_id': cart.user.id,
          'quantity': cart.quantity,
        }));

    if (response.statusCode != 200) {
      return ApiReturnValue(message: 'Please try again');
    }

    var data = jsonDecode(response.body);
    List<CartModel> cartmodel = (data['data']['data'] as Iterable)
        .map((e) => CartModel.fromJson(e))
        .toList();

    return ApiReturnValue(value: cartmodel);
  }

  static Future<bool> cekCurrentfood(CartModel cartModel,
      {http.Client client}) async {
    if (client == null) {
      client = http.Client();
    }

    String url = baseUrl + 'getcart';
    var response = await client.get(url, headers: {
      "Content-Type": "application/json",
      "Authorization": "Bearer ${User.token}"
    });
    if (response.statusCode != 200) {
      return false;
    }

    var data = jsonDecode(response.body);

    List<CartModel> cart = (data['data']['data'] as Iterable)
        .map((e) => CartModel.fromJson(e))
        .toList();
    int index = cart.indexWhere((i) => i.food.id == cartModel.food.id);

    if (index != -1) {
      return true;
    } else
      // var int id_food = transaction.where((element) => element.id);
      return false;
  }
}
