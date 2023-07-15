abstract class AppStates {}

class AppInitialState extends AppStates{}

class ChangeScreenState extends AppStates{}

class GetHomeDataLoadingState extends AppStates{}

class GetHomeDataSuccessState extends AppStates{}

class GetHomeDataErrorState extends AppStates{}

class ChangeFavoritesLoadingState extends AppStates{}

class ChangeFavoritesSuccessState extends AppStates{}

class ChangeFavoritesErrorState extends AppStates{}

class GetFavoritesLoadingState extends AppStates{}

class GetFavoritesSuccessState extends AppStates{}

class GetFavoritesErrorState extends AppStates{}

class AddToCartLoadingState extends AppStates{}

class AddToCartSuccessState extends AppStates{}

class GetCartDataLoadingState extends AppStates{}

class GetCartDataSuccessState extends AppStates{}

class GetCartDataErrorState extends AppStates{}

class AddToCartErrorState extends AppStates{}

class ChangeSliderIndex extends AppStates{}

class ChangeCartButton extends AppStates{}