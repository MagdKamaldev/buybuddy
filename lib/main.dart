// ignore_for_file: prefer_const_constructors
import 'package:buybuddy/cubit/checkout/checkout_cubit.dart';
import 'package:buybuddy/cubit/signup/sign_up_cubit.dart';
import 'package:buybuddy/firebase_options.dart';
import 'package:buybuddy/modules/home/home_layout.dart';
import 'package:buybuddy/modules/onboarding/on_borading.dart';
import 'package:buybuddy/modules/onboarding/sign_in.dart';
import 'package:buybuddy/shared/components/bloc_observer.dart';
import 'package:buybuddy/shared/networks/cache_helper.dart';
import 'package:buybuddy/shared/networks/dio_helper.dart';
import 'package:buybuddy/shared/networks/payment_dio_helper.dart';
import 'package:buybuddy/shared/styles/themes.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'cubit/app/app_cubit.dart';
import 'cubit/app/app_states.dart';
import 'cubit/cart/cart_cubit.dart';
import 'cubit/favourites/favourites_cubit.dart';
import 'cubit/login/login_cubit.dart';
import 'cubit/payment/payment_cubit.dart';

String? token = "";

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  DioHelper.init();
  PaymentDioHelper.init();
  await CacheHelper.init();
  Bloc.observer = MyBlocObserver();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  Widget? widget;
  token = CacheHelper.getData(key: "token");
  String? start = CacheHelper.getData(key: "start");
  if (start == "home") {
    widget = HomeLayout();
  } else if (start == "signIn") {
    widget = SignInPage();
  } else {
    widget = OnBoarding();
  }
  runApp(MyApp(
    startWidget: widget,
  ));
}

class MyApp extends StatelessWidget {
  final Widget startWidget;

  const MyApp({super.key, required this.startWidget});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) {
          return AppCubit()..selectWelcomeTime();
        }),
        BlocProvider(create: (context) {
          return FavoritesCubit()..getFavouritesData();
        }),
        BlocProvider(create: (context) {
          return CheckOutCubit();
        }),
        BlocProvider(create: (context) {
          return CartCubit();
        }),
        BlocProvider(create: (context) {
          return LoginCubit();
        }),
        BlocProvider(create: (context) {
          return SignUpCubit();
        }),
        BlocProvider(create: (context) {
          return CheckOutCubit()..requestPermission();
        }),
        BlocProvider(create: (context) {
          return PaymentCubit();
        }),
      ],
      child: BlocConsumer<AppCubit, AppStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return MaterialApp(
            title: 'Buy Buddy',
            debugShowCheckedModeBanner: false,
            theme: theme,
            home: startWidget,
          );
        },
      ),
    );
  }
}
