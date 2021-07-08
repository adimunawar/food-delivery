part of 'pages.dart';

class FoodPage extends StatefulWidget {
  @override
  _FoodPageState createState() => _FoodPageState();
}

class _FoodPageState extends State<FoodPage> {
  int selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    double listItemWidth =
        MediaQuery.of(context).size.width - 2 * defaultMargin;
    return ListView(
      children: [
        Column(
          children: [
            //Head
            Container(
              color: Colors.white,
              height: 100,
              width: double.infinity,
              margin: EdgeInsets.symmetric(horizontal: defaultMargin),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Food Marker",
                        style: blackFontStyle1,
                      ),
                      Text(
                        "Let's get some foods",
                        style: blackFontStyle3.copyWith(
                            color: greyColor, fontWeight: FontWeight.w300),
                      )
                    ],
                  ),
                  Container(
                    width: 50,
                    height: 50,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        image: DecorationImage(
                            image: NetworkImage(
                                (context.bloc<UserCubit>().state as UserLoaded)
                                    .user
                                    .picturePath),
                            fit: BoxFit.cover)),
                  )
                ],
              ),
            ),
            //list of Foof
            Container(
              height: 258,
              width: double.infinity,
              child: BlocBuilder<FoodCubit, FoodState>(
                  builder: (_, state) => (state is FoodLoaded)
                      ? ListView(
                          scrollDirection: Axis.horizontal,
                          children: [
                            Row(
                              children: state.foods
                                  .map((e) => Padding(
                                      padding: EdgeInsets.only(
                                          left:
                                              (e == state.foods.first) ? 24 : 0,
                                          right: 24),
                                      child: GestureDetector(
                                          onTap: () {
                                            Get.to(FoodDetailPage(
                                              transaction: Transaction(
                                                user: (context
                                                        .bloc<UserCubit>()
                                                        .state as UserLoaded)
                                                    .user,
                                                food: e,
                                              ),
                                              onBackButttonPressed: () {
                                                Get.back();
                                              },
                                            ));
                                          },
                                          child: FoodCard(e))))
                                  .toList(),
                            )
                          ],
                        )
                      : Center(
                          child: loadingIndicator,
                        )),
            ),
            Container(
              width: double.infinity,
              color: Colors.white,
              child: Column(
                children: [
                  CustomTabbar(
                    titles: ['New Taste', 'Popular', 'Recommended'],
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
                  BlocBuilder<FoodCubit, FoodState>(builder: (_, state) {
                    if (state is FoodLoaded) {
                      List<Food> foods = state.foods
                          .where((element) =>
                              element.types.contains((selectedIndex == 0)
                                  ? FoodType.new_food
                                  : (selectedIndex == 1)
                                      ? FoodType.popular
                                      : FoodType.recomended))
                          .toList();
                      return Column(
                        children: foods
                            .map((e) => Padding(
                                  padding: EdgeInsets.fromLTRB(24, 0, 24, 16),
                                  child: GestureDetector(
                                    onTap: () {
                                      Get.to(FoodDetailPage(
                                        transaction: Transaction(
                                          user: (context.bloc<UserCubit>().state
                                                  as UserLoaded)
                                              .user,
                                          food: e,
                                        ),
                                        onBackButttonPressed: () {
                                          Get.back();
                                        },
                                      ));
                                    },
                                    child: FoodListItems(
                                      food: e,
                                      itemWidth: listItemWidth,
                                    ),
                                  ),
                                ))
                            .toList(),
                      );
                    } else {
                      return Center(
                        child: loadingIndicator,
                      );
                    }
                  }),
                ],
              ),
            ),
            SizedBox(
              height: 80,
            )
            //list off food(tabs)
          ],
        )
      ],
    );
  }
}
