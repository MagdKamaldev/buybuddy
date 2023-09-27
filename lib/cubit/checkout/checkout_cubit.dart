// ignore_for_file: unused_local_variable, use_build_context_synchronously
import 'dart:async';
import 'dart:convert';
import 'package:buybuddy/cubit/cart/cart_cubit.dart';
import 'package:buybuddy/models/get_cart_model.dart';
import 'package:buybuddy/models/order_model.dart';
import 'package:buybuddy/shared/networks/cache_helper.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../../shared/components/components.dart';
import '../../shared/styles/colors.dart';
import 'checkout_states.dart';

class CheckOutCubit extends Cubit<CheckOutStates> {
  CheckOutCubit() : super(CheckOutInitialState()) {
    requestPermission();
  }

  static CheckOutCubit get(context) => BlocProvider.of(context);

  bool? servicesEnabled;
  LocationPermission? permission;

  Future requestPermission() async {
    emit(ResquestPermissionLoadingState());

    servicesEnabled = await Geolocator.isLocationServiceEnabled();
    permission = await Geolocator.checkPermission();

    permission = await Geolocator.requestPermission().then((value) {
      if (permission != LocationPermission.denied) {
        getLatLong();
        emit(ResquestPermissionSuccessState());
      } else {
        emit(ResquestPermissionWarningState());
      }
    }).catchError((error) {
      emit(ResquestPermissionErrorState());
    });
  }

  Position? currentLatLong;

  late CameraPosition myPosition;

  void getLatLong() async {
    emit(GetLatLongLoadingState());
    currentLatLong = await Geolocator.getCurrentPosition().then(
      (value) => value,
    );
    //print(currentLatLong!.latitude);
    emit(GetLatLongSuccessState());

    myPosition = CameraPosition(
        target: LatLng(currentLatLong!.latitude, currentLatLong!.longitude),
        zoom: 17.4746);
  }

  List<Placemark> placemarks = [];
  void getCountry() async {
    getLatLong();
    placemarks = await placemarkFromCoordinates(
        currentLatLong!.latitude, currentLatLong!.longitude);
    //print("=================== ${placemarks[0].postalCode}");
  }

  // double mesuredistanceinkm({
  //   required startLat,
  //   required startLong,
  //   required endLat,
  //   required endLong,
  // }) {
  //   return Geolocator.distanceBetween(startLat, startLong, endLat, endLong) /
  //       1000;
  // }

  bool phoneConfirmed = CacheHelper.getData(key: "phoneConfirmed") ?? false;
  bool adressConfirmed = false;
  bool paymentDone = false;
  String currentOrderAdress = "";

  Position? orderLatLong;

  void confirmPaymentSucess(context) {
    CheckOutCubit.get(context).paymentDone = true;
    emit(ConfirmPaymentSuccessState());
  }

  void confirmLocation({
    required var streetController,
    required var buildingController,
    required var floorController,
    required var apartmentController,
    required BuildContext context,
  }) {
    adressConfirmed = true;
    currentOrderAdress =
        "${streetController.text} ${buildingController.text} ${floorController.text} ${apartmentController.text}";

    Navigator.pop(context);
    emit(ConfirmLocationSuccessState());
  }

  void setOrederLocation(double latitude, double longitude) {
    orderLatLong = Position(
        latitude: latitude,
        longitude: longitude,
        timestamp: DateTime.now(),
        accuracy: 10.0,
        altitude: 0.0,
        heading: 0.0,
        speed: 0.0,
        speedAccuracy: 0.0);

    emit(SetOrderLoactionState());
  }

  Set<Marker> myMarkers = {};

  void setMarkerCustomImage(context) async {
    emit(SetMarkerLoadingState());
    myMarkers.clear();
    myMarkers.add(Marker(
      onTap: () => showCustomSnackBar(context, "Long press to move", ivory),
      markerId: const MarkerId('userLocationMarker'),
      position: CheckOutCubit.get(context).orderLatLong == null
          ? LatLng(
              CheckOutCubit.get(context).currentLatLong!.latitude,
              CheckOutCubit.get(context).currentLatLong!.longitude,
            )
          : LatLng(CheckOutCubit.get(context).orderLatLong!.latitude,
              CheckOutCubit.get(context).orderLatLong!.longitude),
      draggable: true,
      onDragEnd: (LatLng t) {},
      icon: await BitmapDescriptor.fromAssetImage(
        ImageConfiguration.empty,
        "assets/images/marker.png",
      ),
    ));
    emit(SetMarkerSuccessState());
  }

  var otpCodeController = TextEditingController();

  Future phoneLogin(
    BuildContext context,
    String number,
  ) async {
    FirebaseAuth.instance.verifyPhoneNumber(
        phoneNumber: number,
        verificationCompleted: (AuthCredential credential) async {
          // await FirebaseAuth.instance.signInWithCredential(credential);
          showCustomSnackBar(
              context, "Phone number successfully confirmed", Colors.green);
          phoneConfirmed = true;
          emit(VerifyCodeSuccessState());
        },
        verificationFailed: (FirebaseAuthException error) {
          showCustomSnackBar(context, error.toString(), Colors.red);
        },
        codeSent: (String verificationId, int? forceResendingToken) {
          showDialog(
              barrierDismissible: false,
              context: context,
              builder: (context) {
                return AlertDialog(
                  title: const Text("Enter Code"),
                  content: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      TextField(
                        controller: otpCodeController,
                        decoration: InputDecoration(
                          prefixIcon: const Icon(Icons.code),
                          errorBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: const BorderSide(color: Colors.red)),
                          enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide(color: indigoDye)),
                          focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: const BorderSide(color: Colors.grey)),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: indigoDye,
                        ),
                        onPressed: () async {
                          final code = otpCodeController.text.trim();
                          AuthCredential authCredential =
                              PhoneAuthProvider.credential(
                            verificationId: verificationId,
                            smsCode: code,
                          );

                          try {
                            await FirebaseAuth.instance
                                .signInWithCredential(authCredential);
                            Navigator.pop(context);
                            showCustomSnackBar(
                                context,
                                "Phone number successfully confirmed",
                                Colors.green);
                            phoneConfirmed = true;
                            CacheHelper.saveData(
                                key: "phoneConfirmed", value: true);
                            emit(VerifyCodeSuccessState());
                          } on FirebaseAuthException catch (error) {
                            showCustomSnackBar(
                                context,
                                "Phone verification failed: ${error.message}",
                                Colors.red);
                          }
                          Navigator.pop(context);
                        },
                        child: Text(
                          "confirm",
                          style: Theme.of(context)
                              .textTheme
                              .bodyLarge!
                              .copyWith(color: ivory),
                        ),
                      ),
                    ],
                  ),
                );
              });
        },
        codeAutoRetrievalTimeout: (String verification) {});
  }

  List<OrderModel> orders = [];

  void checkout({
    required BuildContext context,
  }) {
    if (phoneConfirmed && adressConfirmed && paymentDone) {
      for (CartItems item
          in CartCubit.get(context).getCartModel!.data!.cartItems!) {
        CartCubit.get(context).addToCart(item.id!, context);
      }
      orders.add(
        OrderModel(
            CartCubit.get(context).getCartModel!.data!.cartItems!,
            orderLatLong == null ? 0.0 : orderLatLong!.latitude,
            orderLatLong == null ? 0.0 : orderLatLong!.longitude,
            CartCubit.get(context).getCartModel!.data!.total!,
            currentOrderAdress,
            DateTime.now()),
      );

      List<Map<String, dynamic>> ordersJson =
          orders.map((order) => order.toJson()).toList();

      String ordersJsonString = jsonEncode(ordersJson);

      CacheHelper.saveData(key: 'orders', value: ordersJsonString);

      showCustomSnackBar(context, "Order Placed", Colors.green);
      debugPrint(CacheHelper.getData(key: "orders"));
      emit(CheckoutSuccessState());
    } else {
      showCustomSnackBar(context,
          "Cannot place Order Without the previous steps !", Colors.red);
      emit(CheckoutErrorState());
    }
  }
}
