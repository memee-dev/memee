import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:memee/core/utils/helper.dart';

class HideCubit extends Cubit<bool> {
  HideCubit() : super(false);

  show(bool value) {
    Future.delayed(const Duration(seconds: 2), () {
      emit(value);
    });
  }
}

class SwitchCubit extends Cubit<bool> {
  SwitchCubit() : super(false);

  void initialValue(bool val) => emit(val);

  void change() => emit(!state);

  getSmsValue() async {
    final value = await HelperFunc.getSms();
    emit(value);
  }

  setSmsValue(bool value) async {
    await HelperFunc.setSms(value);
  }

  getNotificationValue() async {
    final value = await HelperFunc.getNotification();
    emit(value);
  }

  setNotificationValue(bool value) async {
    await HelperFunc.setNotification(value);
  }
}
