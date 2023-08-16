import '../../models/login_model.dart';

abstract class AppStates {}

class AppInitialState extends AppStates{}

class InitializationLoadingState extends AppStates{}

class InitializationSuccessState extends AppStates{}

class InitializationErrorState extends AppStates{}

class ChangeScreenState extends AppStates{}

class GetHomeDataLoadingState extends AppStates{}

class GetHomeDataSuccessState extends AppStates{}

class GetHomeDataErrorState extends AppStates{}



class ChangeSliderIndex extends AppStates{}

class GetUserDataLoadingState extends AppStates{}

class GetUserDataSuccessState extends AppStates{
   final LoginModel loginModel;
  GetUserDataSuccessState(this.loginModel);
}

class UpdateUserDataLoadingState extends AppStates {}

class UpdateUserDataSuccessState extends AppStates {
  final LoginModel loginModel;
  UpdateUserDataSuccessState(this.loginModel);
}

class UpdateUserDataErrorState extends AppStates {}

class GetUserDataErrorState extends AppStates{}

class ChangeCartButton extends AppStates{}