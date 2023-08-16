import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
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
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission().then((value) {
        if (servicesEnabled == true) {
          getLatLong();
        }
        emit(ResquestPermissionSuccessState());
      }).catchError((error) {
        emit(ResquestPermissionErrorState());
      });
    }
  }

  Position? currentLatLong;

  void getLatLong() async {
    emit(GetLatLongLoadingState());
    currentLatLong = await Geolocator.getCurrentPosition().then(
      (value) => value,
    );
    //print(currentLatLong!.latitude);
    emit(GetLatLongSuccessState());
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
}
