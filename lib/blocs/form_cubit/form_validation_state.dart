part of 'form_validation_cubit.dart';

class FormValidationState extends Equatable {
  @override
  List<Object?> get props => [];
}

class FormValidationInitial extends FormValidationState {}

class StreetEmpty extends FormValidationState {
  final String? message;

  StreetEmpty({this.message});
}

class HouseNoEmpty extends FormValidationState {
  final String? message;

  HouseNoEmpty({this.message});
}

class AreaEmpty extends FormValidationState {
  final String? message;

  AreaEmpty({this.message});
}

class CityEmpty extends FormValidationState {
  final String? message;

  CityEmpty({this.message});
}

class PinCodeEmpty extends FormValidationState {
  final String? message;

  PinCodeEmpty({this.message});
}

class FormSubmit extends FormValidationState {
  final bool valid;

  FormSubmit({required this.valid});
}
