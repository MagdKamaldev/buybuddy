import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'map_states.dart';

class MapCubit extends Cubit<MapStates> {
  MapCubit() : super(MapInitialState()) {
    getPosition();
  }

  static MapCubit get(context) => BlocProvider.of(context);

  bool? servicesEnabled;
  LocationPermission? permission;

  Future getPosition() async {
    servicesEnabled = await Geolocator.isLocationServiceEnabled();
    if (servicesEnabled == false) {}

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
    }
  }

  Position? currentLatLong;
  void getLatLong() async {
    emit(GetLatLongLoadingState());
    currentLatLong = await Geolocator.getCurrentPosition().then(
      (value) => value,
    );
    print(currentLatLong!.latitude);
    emit(GetLatLongSuccessState());
  }
}
