import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:memee/core/utils/app_di.dart';
import 'package:memee/models/user_model.dart';

enum RegisterState {
  phoneNumber,
  otp,
}

class RegisterCubit extends Cubit<RegisterState> {
  final auth = locator.get<FirebaseAuth>();
  final db = locator.get<FirebaseFirestore>();

  String? phoneNumber;
  String? verificationId;
  int? resendToken;

  late UserModel? loginUser;

  RegisterCubit() : super(RegisterState.phoneNumber);

  void back() {
    int backIndex = state.index - 1;
    if (backIndex > -1) {
      emit(RegisterState.values[backIndex]);
    }
  }
}
