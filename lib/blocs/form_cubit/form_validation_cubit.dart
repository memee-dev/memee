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
      emit(FormValidationInitial());
    }
  }

  validateHouseNo(String text) {
    emit(FormValidationInitial());
    if (text.isEmpty) {
      emit(HouseNoEmpty(
          message:
              'Please enter house/flat no to proceed')); // ValidationFationFailure
    } else {
      emit(FormValidationInitial());
    }
  }

  validateArea(String text) {
    emit(FormValidationInitial());
    if (text.isEmpty) {
      emit(AreaEmpty(
          message: 'Please enter area to proceed')); // ValidationFationFailure
    } else {
      emit(FormValidationInitial());
    }
  }

  validateCity(String text) {
    emit(FormValidationInitial());
    if (text.isEmpty) {
      emit(CityEmpty(
          message: 'Please enter area to proceed')); // ValidationFationFailure
    } else {
      emit(FormValidationInitial());
    }
  }

  validatePinCode(String text) {
    emit(FormValidationInitial());
    if (text.isEmpty) {
      emit(PinCodeEmpty(
          message:
              'Please enter pin code to proceed')); // ValidationFationFailure
    } else {
      emit(FormValidationInitial());
    }
  }

  validateMobileNumber(String value) {
    emit(FormValidationInitial());

    if (value.isEmpty) {
      emit(MobileNumberError(
          message: 'Mobile number cannot be empty')); // ValidationFationFailure
    } else if (value.length < 10) {
      emit(MobileNumberError(
          message:
              'Please enter a valid mobile number to proceed')); // ValidationFationFailure
    } else {
      emit(FormValidationInitial());
    }
  }
}
