/// YApi QuickType插件生成，具体参考文档:https://plugins.jetbrains.com/plugin/18847-yapi-quicktype/documentation

import 'dart:convert';

LocationModel locationModelFromJson(String str) => LocationModel.fromJson(json.decode(str));

String locationModelToJson(LocationModel data) => json.encode(data.toJson());

class LocationModel {
    LocationModel({
        required this.latitude,
        required this.longitude,
    });

    double latitude;
    double longitude;

    factory LocationModel.fromJson(Map<dynamic, dynamic> json) => LocationModel(
        latitude: json['latitude'],
        longitude: json['longitude'],
    );

    Map<dynamic, dynamic> toJson() => {
        'latitude': latitude,
        'longitude': longitude,
    };
}
