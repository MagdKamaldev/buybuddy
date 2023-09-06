import 'dart:async';

import 'package:buybuddy/cubit/app/app_cubit.dart';
import 'package:buybuddy/modules/home/checkout/confirm_code_screen.dart';
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

  Duration duration = const Duration(seconds: 120);

  //I call this to get the number
  void verifyNumber({
    required String number,
    required BuildContext context,
  }) async {
    emit(VerifyNumberLoadingState());
    await FirebaseAuth.instance.verifyPhoneNumber(
      phoneNumber: number,
      verificationCompleted: (PhoneAuthCredential credential) {
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
      codeSent: (String verificationId, int? resendToken) {
        startTimer();

        navigateTo(
            context,
            ConfirmCode(
                number: number == ""
                    ? "+20${AppCubit.get(context).userModel!.data!.phone!}"
                    : number));

        emit(CodeSentState());
      },
      timeout: duration,
      codeAutoRetrievalTimeout: (String verificationId) {},
    );
  }

  late Timer timer;
  Duration remainingDuration = Duration.zero;

  void startTimer() {
    remainingDuration = duration;
    timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      remainingDuration -= const Duration(seconds: 1);
      if (remainingDuration == const Duration(seconds: 0)) {
        timer.cancel();
      }
      emit(TimerState());
    });
  }

  void stopTimer() {
    timer.cancel();
  }

  FirebaseAuth auth = FirebaseAuth.instance;
  UserCredential? userCredential;

//I call this when I confirm the code
  void confirmPhoneNumber({
    required String number,
    required String code,
    required BuildContext context,
  }) async {
    emit(VerifyCodeLoadingState());
    ConfirmationResult confirmationResult = await auth.signInWithPhoneNumber(
      number,
    );
    userCredential = await confirmationResult.confirm(code).then((value) {
      stopTimer();
      Navigator.pop(context);
      Navigator.pop(context);
      emit(VerifyCodeSuccessState());
    }).catchError((error) {
      showCustomSnackBar(context, error.message.toString(), Colors.red);
      emit(VerifyCodeErrorState());
    });
  }
}
