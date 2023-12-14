import 'package:flutter_bloc/flutter_bloc.dart';

class RefreshCubit extends Cubit<bool> {
  RefreshCubit() : super(false);

  void initialValue(bool val) => emit(val);
  void change() => emit(!state);
}
