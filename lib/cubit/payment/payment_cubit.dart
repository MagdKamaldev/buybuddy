import 'package:bloc/bloc.dart';
import 'package:buybuddy/shared/networks/payment_constants.dart';
import 'package:buybuddy/shared/networks/payment_dio_helper.dart';
import 'package:flutter/material.dart';
part 'payment_states.dart';

class PaymentCubitCubit extends Cubit<PaymentStates> {
  PaymentCubitCubit() : super(PaymentCubitInitial());

  Future<void> getAuthToken() async {
    emit(PaymentAuthLoadingState());
    PaymentDioHelper.postData(url: PayMobConst.getAuthToken, data: {
      "Api_key": PayMobConst.paymentApiKey,
    }).then((value) {
      PayMobConst.paymentAuthToken = value.data["token"];
      print("token ${PayMobConst.paymentAuthToken})");
      emit(PaymentAuthSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(PaymentAuthErrorState());
    });
  }

  Future getOrderRegisterationId({
    required String name,
    required String email,
    required String phone,
    required String price,
  }) async {
    emit(GetOrderRegisterationIdLoadingState());
    PaymentDioHelper.postData(url: PayMobConst.paymobBaseUrl, data: {
      "auth_token": PayMobConst.paymentAuthToken,
      "delivery_needed": "false",
      "amount_cents": price,
      "currency": "EGP",
      "merchant_order_id": 5,
    }).then((value) {
      PayMobConst.paymentOrderId = value.data["id"];
      getPaymentRequest(name: name, email: email, phone: phone, price: price);
      emit(GetOrderRegisterationIdSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(GetOrderRegisterationIdErrorState());
    });
  }

  Future<void> getPaymentRequest({
    required String name,
    required String email,
    required String phone,
    required String price,
  }) async {
    emit(GetPaymentRequestLoadingState());
    PaymentDioHelper.postData(url: PayMobConst.getPaymentId, data: {
      "auth_token": PayMobConst.paymentAuthToken,
      "amount_cents": price,
      "expiration": 3600,
      "order_id": PayMobConst.paymentOrderId,
      "billing_data": {
        "apartment": "NA",
        "email": email,
        "floor": "NA",
        "first_name": name,
        "street": "NA",
        "building": "NA",
        "phone_number": phone,
        "shipping_method": "NA",
        "postal_code": "NA",
        "city": "NA",
        "country": "NA",
        "last_name": "NA",
        "state": "NA"
      },
      "currency": "EGP",
      "integration_id": PayMobConst.integrationIdCard,
      "lock_order_when_paid": "false"
    }).then((value) {
      PayMobConst.finalToken = value.data["token"];
      emit(GetPaymentRequestSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(GetPaymentRequestErrorState());
    });
  }

  Future<void> getRefCode() async {
    emit(GetRefCodeLoadingState());
    PaymentDioHelper.postData(url: PayMobConst.getRefCode, data: {
      "source": {"identifier": "AGGREGATOR", "subtype": "AGGREGATOR"},
      "payment_token": PayMobConst.finalToken,
    }).then((value) {
      print("got Ref Code");
      PayMobConst.refCode = value.data["id"].toString();
      emit(GetRefCodeSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(GetRefCodeErrorState());
    });
  }
}
