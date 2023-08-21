part of 'payment_cubit.dart';

@immutable
sealed class PaymentStates {}

class PaymentCubitInitial extends PaymentStates {}

class PaymentAuthLoadingState extends PaymentStates {}

class PaymentAuthSuccessState extends PaymentStates {}

class PaymentAuthErrorState extends PaymentStates {}

class GetOrderRegisterationIdLoadingState extends PaymentStates {}

class GetOrderRegisterationIdSuccessState extends PaymentStates {}

class GetOrderRegisterationIdErrorState extends PaymentStates {}

class GetPaymentRequestLoadingState extends PaymentStates {}

class GetPaymentRequestSuccessState extends PaymentStates {}

class GetPaymentRequestErrorState extends PaymentStates {}

class GetRefCodeLoadingState extends PaymentStates{}

class GetRefCodeSuccessState extends PaymentStates{}

class GetRefCodeErrorState extends PaymentStates{}



