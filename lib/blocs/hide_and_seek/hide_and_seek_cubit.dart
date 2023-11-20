import 'package:flutter_bloc/flutter_bloc.dart';

class HideAndSeekCubit extends Cubit<bool> {
  HideAndSeekCubit() : super(false);

  void initialValue(bool val) => emit(val);
  void change() => emit(!state);
}
