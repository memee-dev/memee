import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'form_validation_state.dart';

class FormValidationCubit extends Cubit<FormValidationState> {
  FormValidationCubit() : super(FormValidationInitial());

  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  validateStreet(String text) {
    emit(FormValidationInitial());
    if (text.isEmpty) {
      emit(StreetEmpty(message: 'Street cannot be empty')); // ValidationFailure
    } else {
      emit(StreetEmpty(message: '')); // ValidationFailure
    }
  }

  validateHouseNo(String text) {
    emit(FormValidationInitial());
    if (text.isEmpty) {
      emit(HouseNoEmpty(
          message:
              'Please enter house/flat no to proceed')); // ValidationFationFailure
    } else {
      emit(HouseNoEmpty(message: ''));
    }
  }

  validateArea(String text) {
    emit(FormValidationInitial());
    if (text.isEmpty) {
      emit(AreaEmpty(
          message: 'Please enter area to proceed')); // ValidationFationFailure
    } else {
      emit(AreaEmpty(message: '')); // V
    }
  }

  validateCity(String text) {
    emit(FormValidationInitial());
    if (text.isEmpty) {
      emit(CityEmpty(
          message: 'Please enter area to proceed')); // ValidationFationFailure
    } else {
      emit(CityEmpty(message: '')); // V
    }
  }

  validatePinCode(String text) {
    emit(FormValidationInitial());
    if (text.isEmpty) {
      emit(PinCodeEmpty(
          message:
              'Please enter pin code to proceed')); // ValidationFationFailure
    } else {
      emit(PinCodeEmpty(message: '')); // Validat
    }
  }

  checkValidation() {
    emit(FormValidationInitial());

    if (formKey.currentState!.validate()) {
      emit(FormSubmit(valid: true));
    } else {
      emit(FormSubmit(valid: false));
    }
  }
}
