abstract class CheckOutStates {}

class CheckOutInitialState extends CheckOutStates {}

class ResquestPermissionLoadingState extends CheckOutStates {}

class ResquestPermissionSuccessState extends CheckOutStates {}

class ResquestPermissionErrorState extends CheckOutStates {}

class ResquestPermissionWarningState extends CheckOutStates {}

class GetLatLongLoadingState extends CheckOutStates {}

class GetLatLongSuccessState extends CheckOutStates {}

class GetLatLongErrorState extends CheckOutStates {}

class SetMarkerLoadingState extends CheckOutStates {}

class SetMarkerSuccessState extends CheckOutStates {}

class SetOrderLoactionState extends CheckOutStates {}

class VerifyNumberLoadingState extends CheckOutStates{}

class VerifyNumberSuccessState extends CheckOutStates{}

class CodeSentState extends CheckOutStates{}

class VerifyNumberErrorState extends CheckOutStates{}

class VerifyCodeLoadingState extends CheckOutStates{}

class VerifyCodeSuccessState extends CheckOutStates{}

class VerifyCodeErrorState extends CheckOutStates{}

class CheckoutSuccessState extends CheckOutStates{}

class CheckoutErrorState extends CheckOutStates{}

class ConfirmLocationSuccessState extends CheckOutStates{}

class ConfirmPaymentSuccessState extends CheckOutStates{}