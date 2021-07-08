part of 'pages.dart';

class WrapperPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // context.bloc<UserCubit>().ceklogin();

    return BlocBuilder<UserCubit, UserState>(builder: (_, state) {
      if (state is UserLoaded) {
        context.bloc<FoodCubit>().getFoods();
        context.bloc<TransactionCubit>().getTransactions();
        return MainPage();
      }
      return SignInPage();
    });
  }
}
