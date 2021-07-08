part of 'pages.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  List profile = [
    'Edit Profile',
    'Home Address',
    'Security',
    'Payment',
    'logout'
  ];
  List foodmarket = [
    'Rate App',
    'Help Center',
    'Privacy & Policy',
    'Term & Condition'
  ];
  int selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        Column(
          children: [
            Container(
              color: Colors.white,
              width: double.infinity,
              height: 232,
              padding: EdgeInsets.symmetric(horizontal: 24),
              margin: EdgeInsets.only(bottom: 24),
              child: Column(
                children: [
                  GestureDetector(
                    onTap: () {
                      print("${User.token}");
                    },
                    child: Container(
                      width: 110,
                      height: 110,
                      margin: EdgeInsets.only(top: 46, bottom: 16),
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage('assets/photo_border.png')),
                      ),
                      child: Container(
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            image: DecorationImage(
                                image: NetworkImage((context
                                        .bloc<UserCubit>()
                                        .state as UserLoaded)
                                    .user
                                    .picturePath),
                                fit: BoxFit.cover)),
                      ),
                    ),
                  ),
                  Text(
                    (context.bloc<UserCubit>().state as UserLoaded).user.name,
                    style: blackFontStyle2,
                  ),
                  SizedBox(
                    height: 6,
                    width: 0,
                  ),
                  Text(
                      (context.bloc<UserCubit>().state as UserLoaded)
                          .user
                          .email,
                      style: greyFontStyle)
                ],
              ),
            ),
            Container(
              width: double.infinity,
              color: Colors.white,
              child: Column(
                children: [
                  CustomTabbar(
                    titles: ['Account', 'FoodMarket'],
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
                  Column(
                    children: ((selectedIndex == 0) ? profile : foodmarket)
                        .map((e) => Padding(
                              padding: EdgeInsets.only(
                                  bottom: 16,
                                  left: defaultMargin,
                                  right: defaultMargin),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      selectMenu(e);
                                    },
                                    child: Text(
                                      e,
                                      style: blackFontStyle3,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 24,
                                    width: 24,
                                    child: Image.asset(
                                      'assets/right_arrow.png',
                                      fit: BoxFit.contain,
                                    ),
                                  )
                                ],
                              ),
                            ))
                        .toList(),
                  )
                ],
              ),
            ),
          ],
        )
      ],
    );
  }

  void selectMenu(String menu) async {
    switch (menu) {
      case 'logout':
        try {
          await context.bloc<UserCubit>().delete();
          UserState state = context.bloc<UserCubit>().state;
          if (state is UserInitial) {
            Get.to(SignInPage());
          }
        } catch (_) {
          return null;
        }

        // return print('profile');
        break;
      case 'Edit Profile':
        return print('profile');
        break;
      case 'Home Address':
        return print('alamat');
        break;
      case 'Security':
        return print('satpam');
        break;
      case 'Payment':
        return print('tpa');
        break;
      case 'Rate App':
        return print('rate');
        break;
      case 'Help Center':
        return print('center');
        break;
      case 'Privacy & policy':
        return print('poli');
        break;
      case 'Term & Condition':
        return print('term');
        break;
    }
  }
}
