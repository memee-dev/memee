import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:memee/models/location_model.dart';

part 'map_state.dart';

class MapCubit extends Cubit<MapState> {
  MapCubit() : super(MapInitial());

  determinePosition() async {
    emit(MapLoading());
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      emit(MapError('Location Service is disable enable to proceed'));
    }

    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    } else if (permission == LocationPermission.deniedForever) {
      await Geolocator.openLocationSettings();
    } else {
      final position = await Geolocator.getCurrentPosition();
      emit(
        MapSuccess(
          LocationModel(
              latitude: position.latitude, longitude: position.longitude),
        ),
      );
    }
  }
}
