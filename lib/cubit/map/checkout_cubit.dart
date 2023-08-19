import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
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

  // void saveorderLocation(Set<Marker> myMarkers) async {
  //   LatLng markerPosition = myMarkers.first.position;
  //   await CacheHelper.saveData(
  //     key: "latitude",
  //     value: markerPosition.latitude,
  //   );
  //   await CacheHelper.saveData(
  //     key: "longitude",
  //     value: markerPosition.longitude,
  //   );

  //   //print(CacheHelper.getData(key: "latitude"));
  // }
}
