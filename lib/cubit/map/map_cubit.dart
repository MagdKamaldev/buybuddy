import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';

import 'map_states.dart';

class MapCubit extends Cubit<MapStates> {
  MapCubit() : super(MapInitialState());

  static MapCubit get(context) => BlocProvider.of(context);

  bool? servicesEnabled;
  Future getPosition() async {
    servicesEnabled = await Geolocator.isLocationServiceEnabled();
  }
}
