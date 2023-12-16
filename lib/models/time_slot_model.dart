import 'dart:convert';

TimeSlotModel timeSlotModelFromJson(String str) =>
    TimeSlotModel.fromJson(json.decode(str));

String timeSlotModelToJson(TimeSlotModel data) => json.encode(data.toJson());

class TimeSlotModel {
  TimeSlotModel({
    required this.id,
    required this.time,
  });

  String id;
  String time;

  factory TimeSlotModel.fromJson(Map<dynamic, dynamic> json) => TimeSlotModel(
        id: json['id'] ?? '',
        time: json['time'] ?? '',
      );

  Map<dynamic, dynamic> toJson() => {
        'id': id,
        'time': time,
      };
}
