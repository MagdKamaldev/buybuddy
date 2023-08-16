abstract class CheckOutStates {}

class CheckOutInitialState extends CheckOutStates{}

class ResquestPermissionLoadingState extends CheckOutStates{}

class ResquestPermissionSuccessState extends CheckOutStates{}

class ResquestPermissionErrorState extends CheckOutStates{}

class GetLatLongLoadingState extends CheckOutStates{}

class GetLatLongSuccessState extends CheckOutStates{}

class GetLatLongErrorState extends CheckOutStates{}
