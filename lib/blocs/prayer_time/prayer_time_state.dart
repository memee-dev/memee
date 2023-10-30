part of 'prayer_time_cubit.dart';

sealed class PrayerTimeState extends Equatable {
  const PrayerTimeState();

  @override
  List<Object> get props => [];
}

final class PrayerTimeInitial extends PrayerTimeState {}

final class PrayerTimeLoading extends PrayerTimeState {}

final class PrayerTimeSuccess extends PrayerTimeState {
  final PrayerTimeEntity prayerTimeEntity;

  const PrayerTimeSuccess({required this.prayerTimeEntity});
}

final class PrayerTimeFailure extends PrayerTimeState {
  final String message;

  const PrayerTimeFailure({required this.message});
}
