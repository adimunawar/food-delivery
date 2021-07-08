part of 'pages.dart';

class OrderHistoryPage extends StatefulWidget {
  @override
  _OrderHistoryPageState createState() => _OrderHistoryPageState();
}

class _OrderHistoryPageState extends State<OrderHistoryPage> {
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TransactionCubit, TransactionState>(builder: (_, state) {
      if (state is TransactionLoaded) {
        if (state.transactions.length == 0) {
          return IlustrationPage(
              title: 'Ouch! Hungry',
              subtitle: 'seems you like have not \n ordered any food yet',
              picturePath: 'assets/love_burger.png',
              buttonTitle1: 'Fine Foods',
              buttonTap1: () {});
        } else {
          double listItemWidth = MediaQuery.of(context).size.width - 2 * 24;
          return RefreshIndicator(
            onRefresh: () async {
              await context.bloc<TransactionCubit>().getTransactions();
            },
            child: ListView(
              children: [
                Column(
                  children: [
                    //header
                    Container(
                      height: 100,
                      width: double.infinity,
                      margin: EdgeInsets.only(bottom: 24),
                      padding: EdgeInsets.symmetric(horizontal: 24),
                      color: Colors.white,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Your Orders',
                            style: blackFontStyle1,
                          ),
                          Text('Wait for the best meal',
                              style: greyFontStyle.copyWith(
                                  fontWeight: FontWeight.w300))
                        ],
                      ),
                    ),

                    //body
                    Container(
                      width: double.infinity,
                      color: Colors.white,
                      child: Column(
                        children: [
                          CustomTabbar(
                            titles: ['In Progress', 'Past Order'],
                            selectedIndex: selectedIndex,
                            ontap: (index) {
                              setState(() {
                                selectedIndex = index;
                              });
                            },
                          ),
                          SizedBox(
                            height: 16,
                          ),
                          Builder(builder: (_) {
                            List<Transaction> transactions =
                                (selectedIndex == 0)
                                    ? state.transactions
                                        .where((element) =>
                                            element.status ==
                                                TransactionStatus.on_delivery ||
                                            element.status ==
                                                TransactionStatus.pending)
                                        .toList()
                                    : state.transactions
                                        .where((element) =>
                                            element.status ==
                                                TransactionStatus.delivered ||
                                            element.status ==
                                                TransactionStatus.cancelled)
                                        .toList();
                            return Column(
                                children: transactions
                                    .map((e) => Padding(
                                          padding: EdgeInsets.only(
                                              right: 24, left: 24, bottom: 16),
                                          child: GestureDetector(
                                            onTap: () async {
                                              if (e.status ==
                                                  TransactionStatus.pending) {
                                                await launch(e.paymentUrl);
                                              }
                                            },
                                            child: OrderListItem(
                                              itemWidth: listItemWidth,
                                              transaction: e,
                                            ),
                                          ),
                                        ))
                                    .toList());
                          })
                        ],
                      ),
                    )
                  ],
                ),
              ],
            ),
          );
        }
      } else {
        return Center(
          child: loadingIndicator,
        );
      }
    });
  }
}
