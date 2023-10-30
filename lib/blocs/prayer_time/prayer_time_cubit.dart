import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:memee/core/shared/app_firestore.dart';
import 'package:memee/models/response/prayer_time_entity.dart';

part 'prayer_time_state.dart';

class PrayerTimeCubit extends Cubit<PrayerTimeState> {
  final FirebaseFirestore db;
  PrayerTimeCubit(this.db) : super(PrayerTimeInitial());

  Future<void> fetchStudentData() async {
    emit(PrayerTimeLoading());
    final DocumentReference docRef = db
        .collection(AppFireStoreCollection.prayerTime)
        .doc(AppFireStoreDocId.time);

    try {
      final DocumentSnapshot doc = await docRef.get();
      if (doc.exists) {
        final data =
            PrayerTimeEntity.fromMap(doc.data() as Map<String, dynamic>);
        emit(PrayerTimeSuccess(prayerTimeEntity: data));
      } else {
        emit(const PrayerTimeFailure(message: 'Document does not exist'));
      }
    } catch (e) {
      emit(PrayerTimeFailure(message: 'Error fetching data: $e'));
    }
  }

  Future<void> updateStudentData(Map<String, dynamic> prayerTimeEntity) async {
    emit(PrayerTimeLoading());
    final DocumentReference docRef = db
        .collection(AppFireStoreCollection.prayerTime)
        .doc(AppFireStoreDocId.time);

    try {
      await docRef.update(prayerTimeEntity);
      emit(PrayerTimeSuccess(
          prayerTimeEntity: PrayerTimeEntity.fromMap(prayerTimeEntity)));
    } catch (e) {
      emit(PrayerTimeFailure(message: 'Error updating document: $e'));
    }
  }
}
