import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:memee/core/extensions/string_extension.dart';
import 'package:memee/core/utils/app_firestore.dart';
import 'package:memee/core/utils/app_logger.dart';
import 'package:memee/models/time_slot_model.dart';

enum TimeSlotState {
  initial,
  loading,
  success,
}

class TimeSlotCubit extends Cubit<TimeSlotState> {
  final FirebaseFirestore db;

  TimeSlotCubit(this.db) : super(TimeSlotState.initial);

  List<TimeSlotModel> timeSlots = [];
  String selectedTime = '';
  String slotError = '';
  final DateFormat _format = DateFormat('h:mm a');
  final DateTime _now = DateTime.now();

  Future<void> getTimeSlots() async {
    timeSlots = [];
    emit(TimeSlotState.loading);
    try {
      final slotsDoc =
          await db.collection(AppFireStoreCollection.utilities).get();
      final docData = slotsDoc.docs.first.data();

      for (var data in docData['timeslots']) {
        timeSlots.add(TimeSlotModel.fromJson(data));
      }

      emit(TimeSlotState.success);
    } catch (e) {
      console.e(e);
    }
  }

  compareCurrentTimeWithTimeSlots() {
    try {
      DateTime nextDay = _now.add(const Duration(days: 1));
      DateTime currentSlot;

      bool foundSlot = false;

      for (var slot in timeSlots) {
        DateTime parsedSlot = _format.parse(slot.time);
        currentSlot = DateTime(
          _now.year,
          _now.month,
          _now.day,
          parsedSlot.hour,
          parsedSlot.minute,
        );
        emit(TimeSlotState.success);
        if (_now.isBefore(currentSlot)) {
          foundSlot = true;
          break;
        }
      }

      if (!foundSlot) {
        slotError =
            'Since the time slots are not available for today, Order will be placed automatically for ${nextDay.formatDateOnly()}';
      }
    } on Exception catch (e) {
      console.e(e);
    }
  }

  void setSelectedTime(String time) {
    emit(TimeSlotState.loading);
    try {
      if (timeSlots.isNotEmpty) {
        final _time = timeSlots.firstWhere((element) => element.time == time);
        final parsedTime = _format.parse(_time.time);

        selectedTime = DateTime(_now.year, _now.month, _now.day,
                parsedTime.hour, parsedTime.minute)
            .format();
        emit(TimeSlotState.success);
      }
    } on Exception catch (e) {
      console.e(e);
    }
  }
}
