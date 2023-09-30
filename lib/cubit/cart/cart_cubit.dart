import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../main.dart';
import '../../models/cart_model.dart';
import '../../models/get_cart_model.dart';
import '../../shared/components/components.dart';
import '../../shared/networks/dio_helper.dart';
import '../../shared/networks/end_points.dart';
import 'cart_states.dart';

Map<int, bool> cartItems = {};

class CartCubit extends Cubit<CartStates> with StateStreamable<CartStates> {
  CartCubit() : super(CartInitialState()) {
    getCartData();
  }

  static CartCubit get(context) => BlocProvider.of(context);

  CartData? changeCart;

  void addToCart(int productId, context) {
    cartItems[productId] = !cartItems[productId]!;
    emit(AddToCartLoadingState());
    DioHelper.postData(
      url: carts,
      data: {"product_id": productId},
      authorization: token,
    ).then((value) {
      showCustomSnackBar(
          context,
          value.data["message"],
          value.data["message"] == "Deleted Successfully"
              ? Colors.red
              : Colors.green);

      changeCart = CartData.fromJson(value.data);
      if (!changeCart!.status) {
        cartItems[productId] = !cartItems[productId]!;
      } else {
        getCartData();
      }

      emit(AddToCartSuccessState());
    }).catchError((error) {
      cartItems[productId] = !cartItems[productId]!;
      emit(AddToCartErrorState());
    });
  }

  GetCartModel? getCartModel;

  void getCartData() {
    emit(GetCartDataLoadingState());
    DioHelper.getData(url: carts, authorization: token).then((value) {
      getCartModel = GetCartModel.fromJson(value.data);
      emit(GetCartDataSuccessState());
    }).catchError((error) {
      print("111111111111111111111111111 ${error.toString()}");
      emit(GetCartDataErrorState());
    });
  }
}
