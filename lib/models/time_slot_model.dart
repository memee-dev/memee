import 'dart:convert';

TimeSlotModel timeSlotModelFromJson(String str) =>
    TimeSlotModel.fromJson(json.decode(str));

String timeSlotModelToJson(TimeSlotModel data) => json.encode(data.toJson());

class TimeSlotModel {
  TimeSlotModel({
    required this.id,
    required this.time,
    required this.bufferTime,
  });

  String id;
  String time;
  int bufferTime;

  factory TimeSlotModel.fromJson(Map<dynamic, dynamic> json) => TimeSlotModel(
        id: json['id'] ?? '',
        time: json['time'] ?? '',
        bufferTime: json['bufferTime'] ?? '',
      );

  Map<dynamic, dynamic> toJson() => {
        'id': id,
        'time': time,
        'bufferTime': bufferTime,
      };
}
