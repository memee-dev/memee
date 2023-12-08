import 'package:flutter_bloc/flutter_bloc.dart';

class HideCubit extends Cubit<bool> {
  HideCubit() : super(false);

  show(bool value) {
    Future.delayed(const Duration(seconds: 2), () {
      emit(value);
    });
  }
}
