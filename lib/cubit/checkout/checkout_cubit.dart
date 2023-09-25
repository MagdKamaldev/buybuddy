import 'dart:async';
import 'package:buybuddy/cubit/cart/cart_cubit.dart';
import 'package:buybuddy/models/get_cart_model.dart';
import 'package:buybuddy/models/order_model.dart';
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

  bool phoneConfirmed = false;
  bool adressConfirmed = false;
  bool paymentDone = false;

  Position? orderLatLong;

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

  void verifyNumber({
    required String number,
    required BuildContext context,
  }) async {
    emit(VerifyNumberLoadingState());

    await FirebaseAuth.instance.verifyPhoneNumber(
      phoneNumber: number,
      verificationCompleted: (PhoneAuthCredential credential) {
        //print(credential.token);
        Navigator.pop(context);
        showCustomSnackBar(context, "success", Colors.green);
        emit(VerifyNumberSuccessState());
      },
      verificationFailed: (FirebaseAuthException e) {
        showCustomSnackBar(
          context,
          e.message.toString(),
          Colors.red,
        );
        emit(VerifyNumberErrorState());
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
                    defaultButton(
                      context: context,
                      text: "Confirm",
                      function: () async {
                        // print("11111111");
                        final code = otpCodeController.text.trim();
                        AuthCredential authCredential =
                            PhoneAuthProvider.credential(
                                verificationId: verificationId, smsCode: code);

                        if (authCredential.accessToken != null &&
                            authCredential.accessToken!.isNotEmpty) {
                          phoneConfirmed = true;
                          Navigator.pop(context);
                          emit(VerifyCodeSuccessState());
                        }
                      },
                    ),
                  ],
                ),
              );
            });
      },
      codeAutoRetrievalTimeout: (String verificationId) {},
    );
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
      orders.add(OrderModel(
          CartCubit.get(context).getCartModel!.data!.cartItems!,
          orderLatLong!.latitude,
          orderLatLong!.longitude,
          CartCubit.get(context).getCartModel!.data!.total!,
          DateTime.now()));
      showCustomSnackBar(context, "Order Placed", Colors.green);
      emit(CheckoutSuccessState());
    } else {
      showCustomSnackBar(context,
          "Cannot place Order Without the previous steps !", Colors.red);
      emit(CheckoutErrorState());
    }
  }
}
