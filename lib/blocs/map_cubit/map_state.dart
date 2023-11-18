part of 'map_cubit.dart';

abstract class MapState extends Equatable {
  @override
  List<Object> get props => [];
}

class MapInitial extends MapState {}

class MapLoading extends MapState {}

class MapSuccess extends MapState {
  final LocationModel location;

  MapSuccess(this.location);
}

class MapError extends MapState {
  final String message;

  MapError(this.message);
}
