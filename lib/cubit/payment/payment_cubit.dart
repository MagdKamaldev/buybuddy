import 'package:buybuddy/cubit/app/app_cubit.dart';
import 'package:buybuddy/modules/home/checkout/card_screen.dart';
import 'package:buybuddy/shared/components/components.dart';
import 'package:buybuddy/shared/networks/cache_helper.dart';
import 'package:buybuddy/shared/networks/payment_constants.dart';
import 'package:buybuddy/shared/networks/payment_dio_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
part 'payment_states.dart';

class PaymentCubit extends Cubit<PaymentStates> {
  PaymentCubit() : super(PaymentCubitInitial()) {
    init();
  }

  static PaymentCubit get(context) => BlocProvider.of(context);

  Future<void> getAuthToken() async {
    emit(PaymentAuthLoadingState());
    PaymentDioHelper.postData(url: PayMobConst.getAuthToken, data: {
      "api_key": PayMobConst.paymentApiKey,
    }).then((value) {
      PayMobConst.paymentAuthToken = value.data["token"];
      print("token ${PayMobConst.paymentAuthToken}");
      emit(PaymentAuthSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(PaymentAuthErrorState());
    });
  }

  late int _latestMerchantOrderId;

  void init() async {
    _latestMerchantOrderId =
        await CacheHelper.getData(key: "paymentOrderId") ?? 10;
  }

  Future getOrderRegisterationId({
    required String name,
    required String email,
    required String phone,
    required num price,
    required BuildContext context,
  }) async {
    emit(GetOrderRegisterationIdLoadingState());
    PaymentDioHelper.postData(url: PayMobConst.getOrderId, data: {
      "auth_token": PayMobConst.paymentAuthToken,
      "delivery_needed": "false",
      "amount_cents": price,
      "currency": "EGP",
      "merchant_order_id":
          "${AppCubit.get(context).userModel!.data!.id} ${_latestMerchantOrderId + 1} ${AppCubit.get(context).userModel!.data!.name}",
    }).then((value) {
      PayMobConst.paymentOrderId = value.data["id"].toString();
      //print("payment oder id : ${PayMobConst.paymentOrderId}");
      _latestMerchantOrderId++;
      CacheHelper.saveData(
          key: "paymentOrderId", value: _latestMerchantOrderId);
      getPaymentRequest(
          name: name,
          email: email,
          phone: phone,
          price: price,
          context: context);
      emit(GetOrderRegisterationIdSuccessState());
    });
  }

  Future<void> getPaymentRequest({
    required String name,
    required String email,
    required String phone,
    required num price,
    BuildContext? context,
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
      navigateTo(context, const CardScreen());
      print("final token  ${PayMobConst.finalToken}");
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
