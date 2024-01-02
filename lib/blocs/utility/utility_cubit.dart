import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:memee/core/extensions/string_extension.dart';
import 'package:memee/core/utils/app_firestore.dart';
import 'package:memee/core/utils/app_logger.dart';
import 'package:memee/models/time_slot_model.dart';

enum UtilityState {
  initial,
  loading,
  success,
}

class UtilityCubit extends Cubit<UtilityState> {
  final FirebaseFirestore db;

  UtilityCubit(this.db) : super(UtilityState.initial);

  List<TimeSlotModel> timeSlots = [];
  List<TimeSlotModel> availableSlots = [];
  String? selectedTime;
  String slotError = '';
  bool slotAvailableForToday = false;
  bool instantDelivery = false;
  final DateFormat _format = DateFormat('h:mm a');
  DateTime _now = DateTime.now();

  Future<void> getTimeSlots() async {
    timeSlots = [];
    emit(UtilityState.loading);
    try {
      final slotsDoc =
          await db.collection(AppFireStoreCollection.utilities).get();
      final docData = slotsDoc.docs.first.data();

      for (var data in docData['timeslots']) {
        timeSlots.add(TimeSlotModel.fromJson(data));
      }

      emit(UtilityState.success);
    } catch (e) {
      console.e(e);
    }
  }

  compareCurrentTimeWithTimeSlots() {
    availableSlots = [];
    try {
      DateTime currentSlot;

      instantDelivery = false;
      for (var slot in timeSlots) {
        DateTime parsedSlot = _format.parse(slot.time);
        currentSlot = DateTime(
          _now.year,
          _now.month,
          _now.day,
          parsedSlot.hour,
          parsedSlot.minute,
        );

        DateTime bufferTime =
            currentSlot.subtract(Duration(minutes: slot.bufferTime));

        if (_now.isBefore(bufferTime)) {
          slotAvailableForToday = true;
          availableSlots.add(slot);
          if (state == UtilityState.success) {
            emit(UtilityState.initial);
          }
          emit(UtilityState.success);
        }
      }

      if (availableSlots.isEmpty) {
        availableSlots = timeSlots;
        _now = _now.add(const Duration(days: 1));
        slotError =
            'Since the time slots are not available for today, Order will be placed automatically for ${_now.formatDateOnly()}';
      }
    } on Exception catch (e) {
      console.e(e);
    }
  }

  void setSelectedTime(String time) {
    emit(UtilityState.loading);
    try {
      final _time =
          availableSlots.firstWhere((element) => element.time == time);
      final parsedTime = _format.parse(_time.time);

      selectedTime = DateTime(_now.year, _now.month, _now.day, parsedTime.hour,
              parsedTime.minute)
          .format();
      if (state == UtilityState.success) {
        emit(UtilityState.initial);
      }
      emit(UtilityState.success);
    } on Exception catch (e) {
      console.e(e);
    }
  }

  setInstantDelivery() {
    instantDelivery = !instantDelivery;
    if (state == UtilityState.success) {
      emit(UtilityState.initial);
    }
    emit(UtilityState.success);
  }

  reset() {
    instantDelivery = false;
    selectedTime = null;
    if (state == UtilityState.success) {
      emit(UtilityState.initial);
    }
    emit(UtilityState.success);
  }
}
