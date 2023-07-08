// ignore_for_file: prefer_const_constructors
import 'package:buybuddy/main.dart';
import 'package:buybuddy/models/home_model.dart';
import 'package:buybuddy/modules/home/categories_screen.dart';
import 'package:buybuddy/modules/home/favourites_screen.dart';
import 'package:buybuddy/modules/home/home_screen.dart';
import 'package:buybuddy/modules/home/settings_screen.dart';
import 'package:buybuddy/shared/networks/dio_helper.dart';
import 'package:buybuddy/shared/networks/end_points.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'app_states.dart';

class AppCubit extends Cubit<AppStates> {
  AppCubit() : super(AppInitialState());
  static AppCubit get(context) => BlocProvider.of(context);

  int? screenindex = 0;

  List<Widget> screens = [
    HomeScreen(),
    CategoriesScreen(),
    FavouritesScreen(),
    SettingsScreen(),
  ];

  void changeScreen(int index) {
    screenindex = index;
    if (index == 0) {
      getHomeData();
    }
    emit(ChangeScreenState());
  }

  String? welcomeText;

  DateTime currentDateTime = DateTime.now();
  void selectWelcomeTime() {
    if (currentDateTime.hour < 12) {
      welcomeText = "Morning";
    } else if (currentDateTime.hour < 18) {
      welcomeText = "Afternoon";
    } else {
      welcomeText = "Evening";
    }
  }

  HomeModel? homeModel;

  void getHomeData() {
    emit(GetHomeDataLoadingState());

    DioHelper.getData(
      url: home,
      token: token,
    ).then((value) {
      homeModel = HomeModel.fromJson(value.data);
      emit(GetHomeDataSuccessState());
    }).catchError((error) {
      emit(GetHomeDataErrorState());
    });
  }

  double currentCarouselPage = 0;

  void changeSliderIndex(int index) {
    currentCarouselPage = index.toDouble();
    emit(ChangeSliderIndex());
  }
}
