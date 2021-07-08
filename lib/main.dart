import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:foodmarket/bloc/auth_bloc.dart';
import 'package:foodmarket/bloc/cart_bloc.dart';
// import 'package:foodmarket/bloc/auth_bloc.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'cubit/cubit.dart';
import 'package:foodmarket/ui/pages/pages.dart';
import 'package:get/get.dart';
import 'package:foodmarket/services/services.dart';
// import 'package:foodmarket/models/models.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  HydratedCubit.storage = await HydratedStorage.build();
  runApp(MyApp());
}
//  => runApp(
//         // Injects the Authentication service
//         RepositoryProvider<AuthenticationService>(
//       create: (context) {
//         return FakeAuthenticationService();
//       },
//       // Injects the Authentication BLoC
//       child: BlocProvider<AuthBloc>(
//         create: (context) {
//           final authService =
//               RepositoryProvider.of<AuthenticationService>(context);
//           return AuthBloc(authService)..add(AppLoaded());
//         },
//         child: MyApp(),
//       ),
//     ));

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => UserCubit()),
        BlocProvider(create: (_) => FoodCubit()),
        BlocProvider(create: (_) => TransactionCubit()),
        BlocProvider(create: (_) => CartCubit()),
        // BlocProvider(create: (_) => TransactionCubit()),
      ],
      child:
          GetMaterialApp(debugShowCheckedModeBanner: false, home: WrapperPage()

              //  BlocBuilder<AuthBloc, AuthState>(
              //   builder: (context, state) {
              //     if (state is AuthenticationLoading) {
              //       return SplashPage();
              //     }
              //     if (state is AuthenticationAuthenticated) {
              //       context.bloc<FoodCubit>().getFoods();
              //       context.bloc<TransactionCubit>().getTransactions();
              //       return MainPage();
              //     }
              //     return SignInPage();
              //   },
              // ),
              ),
    );
  }
}
