import 'package:buybuddy/models/login_model.dart';
import 'package:buybuddy/shared/networks/dio_helper.dart';
import 'package:buybuddy/shared/networks/end_points.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'login_states.dart';

class LoginCubit extends Cubit<LoginStates> {
  LoginCubit() : super(LoginInitialState());
  static LoginCubit get(context) => BlocProvider.of(context);

  IconData suffix = Icons.visibility_outlined;
  bool isPassword = true;

  void changePassword() {
    isPassword = !isPassword;
    suffix =
        isPassword ? Icons.visibility_outlined : Icons.visibility_off_outlined;
    emit(ChangePasswordVisibilityState());
  }

  LoginModel? loginModel;

  void userLogin({
    required String email,
    required String password,
  }) {
    emit(LoginLoadingState());
    DioHelper.postData(url: login, lang: "en", data: {
      "email": email,
      "password": password,
    }).then((value) {
      loginModel = LoginModel.fromJson(value.data);
      emit(LoginSuccessState(loginModel!));
    }).catchError((error) {
      emit(LoginErrorState(error.toString()));
    });
  }

  
}
