part of 'pages.dart';

class CartPage extends StatelessWidget {
  const CartPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          BlocBuilder<CartCubit, CartState>(builder: (_, state) {
            if (state is CartCubitLoaded) {
              List<CartModel> cart = state.productCart.toList();
              int total = 0;
              cart.forEach((e) {
                total = total + e.food.price * e.quantity.toInt();
              });
              return Column(
                children: [
                  Column(
                      children: cart
                          .map((e) => Card(
                                child: ListTile(
                                  title: Text(e.food.name),
                                  subtitle: Text(e.food.price.toString()),
                                  trailing: Text(e.quantity),
                                ),
                              ))
                          .toList()),
                  SizedBox(
                    height: 30,
                  ),
                  Divider(),
                  Row(
                    children: [Text("Total Belanja :"), Text(total.toString())],
                  )
                ],
              );
            } else {
              return CircularProgressIndicator();
            }
          }),
        ],
      ),
    );
  }
}
