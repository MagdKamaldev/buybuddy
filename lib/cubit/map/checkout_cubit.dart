import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../../shared/components/components.dart';
import '../../shared/networks/cache_helper.dart';
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

  double mesuredistanceinkm({
    required startLat,
    required startLong,
    required endLat,
    required endLong,
  }) {
    return Geolocator.distanceBetween(startLat, startLong, endLat, endLong) /
        1000;
  }

  Set<Marker> marker = {};
  double? latitude = CacheHelper.getData(key: "latitude");
  double? longitude = CacheHelper.getData(key: "longitude");

  setMarkerCustomImage(context) async {
    emit(SetMarkerLoadingState());
    marker.add(Marker(
      markerId: const MarkerId('userLocationMarker'),
      position: latitude == null || longitude == null
          ? LatLng(
              CheckOutCubit.get(context).currentLatLong!.latitude,
              CheckOutCubit.get(context).currentLatLong!.longitude,
            )
          : LatLng(latitude!, longitude!),
      draggable: true,
      onDragEnd: (LatLng t) {},
      icon: await BitmapDescriptor.fromAssetImage(
        ImageConfiguration.empty,
        "assets/images/location_small.png",
      ),
    ));
    emit(SetMarkerSuccessState());
  }
}
