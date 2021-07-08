part of 'pages.dart';

class SplashPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: mainColor,
        body: Center(
          child: Column(
            // crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                height: 100,
                width: 100,
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage('assets/shop.png'),
                        fit: BoxFit.cover)),
              ),
              Container(
                  margin: EdgeInsets.only(top: 30),
                  child: Text("FoodMarket",
                      style: blackFontStyle1.copyWith(
                        fontSize: 32,
                      )))
            ],
          ),
        ));
  }
}
