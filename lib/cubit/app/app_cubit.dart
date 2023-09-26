// ignore_for_file: prefer_const_constructors, avoid_function_literals_in_foreach_calls
import 'package:buybuddy/main.dart';
import 'package:buybuddy/models/home_model.dart';
import 'package:buybuddy/modules/home/cart_screen.dart';
import 'package:buybuddy/modules/home/favourites_screen.dart';
import 'package:buybuddy/modules/home/home_screen.dart';
import 'package:buybuddy/shared/networks/dio_helper.dart';
import 'package:buybuddy/shared/networks/end_points.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../models/login_model.dart';
import '../cart/cart_cubit.dart';
import '../favourites/favourites_cubit.dart';
import 'app_states.dart';

class AppCubit extends Cubit<AppStates> {
  AppCubit() : super(AppInitialState()) {
    getHomeData();

    getUserData();
  }

  static AppCubit get(context) => BlocProvider.of(context);

  int? screenindex = 0;

  List<Widget> screens = [
    HomeScreen(),
    FavouritesScreen(),
    CartScreen(),
  
  ];

  void changeScreen(int index) {
    screenindex = index;
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

    DioHelper.getData(url: home, token: token, authorization: token)
        .then((value) {
      homeModel = HomeModel.fromJson(value.data);
      homeModel!.data!.products.forEach((element) {
        favourites.addAll({
          element.id!: element.inFavourites!,
        });
        cartItems.addAll({
          element.id!: element.inCart!,
        });
      });

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

  LoginModel? userModel;

  void getUserData() {
    emit(GetUserDataLoadingState());
    DioHelper.getData(url: profile, authorization: token).then((value) {
      userModel = LoginModel.fromJson(value.data);

      emit(GetUserDataSuccessState(userModel!));
    }).catchError((error) {
      emit(GetUserDataErrorState());
    });
  }

  void updateUserData({
    required String name,
    required String phone,
    required String email,
  }) {
    emit(UpdateUserDataLoadingState());
    DioHelper.updateData(url: updateProfile, authorization: token, data: {
      "name": name,
      "email": email,
      "phone": phone,
    }).then((value) {
      userModel = LoginModel.fromJson(value.data);
      //print(userModel!.data!.name);
      emit(UpdateUserDataSuccessState(userModel!));
    }).catchError((error) {
      //  print(error.toString());
      emit(UpdateUserDataErrorState());
    });
  }
}
