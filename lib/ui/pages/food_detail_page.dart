part of 'pages.dart';

class FoodDetailPage extends StatefulWidget {
  final Function onBackButttonPressed;
  final Transaction transaction;

  FoodDetailPage({this.onBackButttonPressed, this.transaction});
  @override
  _FoodDetailPageState createState() => _FoodDetailPageState();
}

class _FoodDetailPageState extends State<FoodDetailPage> {
  bool isLoading = false;
  int quantity = 1;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            color: mainColor,
          ),
          SafeArea(
              child: Container(
            color: Colors.white,
          )),
          SafeArea(
              child: Container(
            height: 300,
            width: double.infinity,
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: NetworkImage(widget.transaction.food.picturePath),
                    fit: BoxFit.cover)),
          )),
          SafeArea(
              child: ListView(
            children: [
              Column(
                children: [
                  Container(
                    height: 100,
                    padding: EdgeInsets.symmetric(horizontal: defaultMargin),
                    child: Align(
                      alignment: Alignment.topLeft,
                      child: GestureDetector(
                        onTap: () {
                          if (widget.onBackButttonPressed != null) {
                            widget.onBackButttonPressed();
                          }
                        },
                        child: Container(
                          margin: EdgeInsets.only(top: 24),
                          padding: EdgeInsets.all(3),
                          width: 30,
                          height: 30,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            color: Colors.black12,
                          ),
                          child: Image.asset('assets/back_arrow_white.png'),
                        ),
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 180),
                    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 26),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(20),
                          topRight: Radius.circular(20),
                        ),
                        color: Colors.white),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(
                                  width:
                                      MediaQuery.of(context).size.width - 134,
                                  child: Text(
                                    widget.transaction.food.name,
                                    style: blackFontStyle2,
                                  ),
                                ),
                                SizedBox(
                                  height: 6,
                                ),
                                RatingStart(rate: widget.transaction.food.rate)
                              ],
                            ),
                            Row(
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      quantity = max(1, quantity - 1);
                                    });
                                  },
                                  child: Container(
                                    width: 26,
                                    height: 26,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(8),
                                        border: Border.all(width: 1),
                                        image: DecorationImage(
                                            image: AssetImage(
                                                'assets/btn_min.png'))),
                                  ),
                                ),
                                SizedBox(
                                  width: 50,
                                  child: Text(
                                    quantity.toString(),
                                    style: blackFontStyle2,
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      quantity = min(999, quantity + 1);
                                    });
                                  },
                                  child: Container(
                                    width: 26,
                                    height: 26,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(8),
                                        border: Border.all(width: 1),
                                        image: DecorationImage(
                                            image: AssetImage(
                                                'assets/btn_add.png'))),
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                        Container(
                          margin: EdgeInsets.fromLTRB(0, 14, 0, 16),
                          child: Text(widget.transaction.food.description,
                              textAlign: TextAlign.justify,
                              style: greyFontStyle),
                        ),
                        Text(
                          'Ingredients : ',
                          style: blackFontStyle3,
                        ),
                        Container(
                          margin: EdgeInsets.fromLTRB(0, 4, 0, 41),
                          child: Text(
                            widget.transaction.food.ingredients,
                            style: greyFontStyle,
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Total Price :',
                                  style: greyFontStyle,
                                ),
                                Text(
                                  NumberFormat.currency(
                                          locale: 'id-ID',
                                          symbol: 'IDR ',
                                          decimalDigits: 0)
                                      .format(quantity *
                                          widget.transaction.food.price),
                                  style: blackFontStyle2.copyWith(fontSize: 18),
                                )
                              ],
                            ),
                            SizedBox(
                              width: 163,
                              height: 45,
                              child: isLoading
                                  ? loadingIndicator
                                  : RaisedButton(
                                      onPressed: () async {
                                        setState(() {
                                          isLoading = true;
                                        });
                                        // bool cekuer =
                                        //     await CartServices.cekCurrentfood(
                                        //         CartModel(
                                        //             food: widget.transaction.food,
                                        //             user: (context
                                        //                     .bloc<UserCubit>()
                                        //                     .state as UserLoaded)
                                        //                 .user,
                                        //             quantity: '2'));

                                        // print(cekuer);
                                        await context
                                            .bloc<CartCubit>()
                                            .addToCart(CartModel(
                                                food: widget.transaction.food,
                                                user: (context
                                                        .bloc<UserCubit>()
                                                        .state as UserLoaded)
                                                    .user,
                                                quantity: quantity.toString()));
                                        CartState state =
                                            context.bloc<CartCubit>().state;
                                        // Get.to(PaymentPage(
                                        //   transaction: widget.transaction.copyWith(
                                        //       quantity: quantity,
                                        //       total: quantity *
                                        //           widget.transaction.food.price),
                                        // ));
                                        if (state is CartCubitLoaded) {
                                          // context.bloc<CartBloc>().add(GetCart());
                                          Get.to(CartPage());
                                        } else if (state
                                            is CartCubitLoadingFailed) {
                                          setState(() {
                                            isLoading = false;
                                          });
                                          Get.snackbar("", "",
                                              backgroundColor:
                                                  "D9435E".toColor(),
                                              icon: Icon(
                                                  MdiIcons.closeCircleOutline,
                                                  color: Colors.white),
                                              titleText: Text(
                                                "gagal nambahkeun",
                                                style: GoogleFonts.poppins(
                                                    color: Colors.white,
                                                    fontWeight:
                                                        FontWeight.w600),
                                              ),
                                              messageText: Text(state.message,
                                                  style: GoogleFonts.poppins(
                                                      color: Colors.white)));
                                        }
                                      },
                                      color: mainColor,
                                      elevation: 0,
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(8)),
                                      child: Text(
                                        'Order Now',
                                        style: blackFontStyle3.copyWith(
                                            fontWeight: FontWeight.w500),
                                      ),
                                    ),
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ))
        ],
      ),
    );
  }
}
