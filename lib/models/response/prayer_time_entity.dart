import 'dart:convert';

import 'package:equatable/equatable.dart';

class PrayerTimeEntity extends Equatable {
  final String fajr;
  final String duhur;
  final String asr;
  final String maghrib;
  final String isha;

  const PrayerTimeEntity({
    required this.fajr,
    required this.duhur,
    required this.asr,
    required this.maghrib,
    required this.isha,
  });

  PrayerTimeEntity copyWith({
    String? fajr,
    String? duhur,
    String? asr,
    String? maghrib,
    String? isha,
  }) {
    return PrayerTimeEntity(
      fajr: fajr ?? this.fajr,
      duhur: duhur ?? this.duhur,
      asr: asr ?? this.asr,
      maghrib: maghrib ?? this.maghrib,
      isha: isha ?? this.isha,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'fajr': fajr,
      'duhur': duhur,
      'asr': asr,
      'maghrib': maghrib,
      'isha': isha,
    };
  }

  int get propertiesCount => toMap().keys.length;

  factory PrayerTimeEntity.fromMap(Map<String, dynamic> map) {
    return PrayerTimeEntity(
      fajr: map['fajr'],
      duhur: map['duhur'],
      asr: map['asr'],
      maghrib: map['maghrib'],
      isha: map['isha'],
    );
  }

  String toJson() => json.encode(toMap());

  factory PrayerTimeEntity.fromJson(String source) =>
      PrayerTimeEntity.fromMap(json.decode(source));

  @override
  String toString() {
    return 'PrayerTimeEntity(fajr: $fajr, duhur: $duhur, asr: $asr, maghrib: $maghrib, isha: $isha)';
  }

  @override
  List<Object> get props {
    return [
      fajr,
      duhur,
      asr,
      maghrib,
      isha,
    ];
  }
}
