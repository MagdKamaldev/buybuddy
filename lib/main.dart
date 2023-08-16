// ignore_for_file: prefer_const_constructors
import 'package:buybuddy/cubit/map/checkout_cubit.dart';
import 'package:buybuddy/modules/home/home_layout.dart';
import 'package:buybuddy/modules/onboarding/on_borading.dart';
import 'package:buybuddy/modules/onboarding/sign_in.dart';
import 'package:buybuddy/shared/networks/cache_helper.dart';
import 'package:buybuddy/shared/networks/dio_helper.dart';
import 'package:buybuddy/shared/styles/themes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'cubit/app/app_cubit.dart';
import 'cubit/app/app_states.dart';
import 'cubit/favourites/favourites_cubit.dart';
import 'cubit/login/login_cubit.dart';
import 'cubit/signup/sign_up_cubit.dart';

String? token = "";

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  DioHelper.init();
  await CacheHelper.init();
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
          return SignUpCubit();
        }),
        BlocProvider(create: (context) {
          return LoginCubit();
        }),
        BlocProvider(create: (context) {
          return CheckOutCubit()
            ..requestPermission()
            ..getLatLong();
        })
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
