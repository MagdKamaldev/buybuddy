import 'package:buybuddy/cubit/signup/sign_up_states.dart';
import 'package:buybuddy/models/login_model.dart';
import 'package:buybuddy/shared/components/components.dart';
import 'package:buybuddy/shared/networks/dio_helper.dart';
import 'package:buybuddy/shared/networks/end_points.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignUpCubit extends Cubit<SignUpStates> {
  SignUpCubit() : super(SignUpInitialState());
  static SignUpCubit get(context) => BlocProvider.of(context);

  IconData suffix = Icons.visibility_outlined;
  bool isPassword = true;

  void changePassword() {
    isPassword = !isPassword;
    suffix =
        isPassword ? Icons.visibility_outlined : Icons.visibility_off_outlined;
    emit(ChangePasswordVisibilityState());
  }

  LoginModel? loginModel;

  void userSignUp({
    required String name,
    required String email,
    required String phone,
    required String password,
    required BuildContext context,
  }) {
    emit(SignUpLoadingState());
    DioHelper.postData(url: register, data: {
      "name": name,
      "email": email,
      "password": password,
      "phone": phone,
    }).then((value) {
      loginModel = LoginModel.fromJson(value.data);
      emit(SignUpSuccessState(loginModel!));
    }).catchError((error) {
      showCustomSnackBar(context, error.toString(), Colors.red);
      emit(SignUpErrorState(error.toString()));
    });
  }
}
