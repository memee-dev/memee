import 'dart:convert';

import 'package:memee/models/cart_model.dart';

OrderModel orderModelFromJson(String str) =>
    OrderModel.fromJson(json.decode(str));

String orderModelToJson(OrderModel data) => json.encode(data.toJson());

class OrderModel {
  OrderModel({
    required this.totalAmount,
    required this.orderedTime,
    required this.address,
    required this.paymentId,
    required this.orders,
    required this.orderStatus,
    required this.paymentStatus,
    this.id,
  });

  String totalAmount;
  String orderedTime;
  String address;
  String paymentId;
  List<CartModel> orders;
  String orderStatus;
  String paymentStatus;
  String? id;

  factory OrderModel.fromJson(Map<dynamic, dynamic> json) => OrderModel(
        totalAmount: json['totalAmount'],
        orderedTime: json['orderedTime'],
        address: json['address'],
        paymentId: json['paymentId'],
        orders: List<CartModel>.from(
            json['orders'].map((x) => CartModel.fromMap(x))),
        orderStatus: json['orderStatus'],
        paymentStatus: json['paymentStatus'],
        id: json['id'],
      );

  Map<dynamic, dynamic> toJson() => {
        'totalAmount': totalAmount,
        'orderedTime': orderedTime,
        'address': address,
        'paymentId': paymentId,
        'orders': List<dynamic>.from(orders.map((x) => x.toJson())),
        'orderStatus': orderStatus,
        'paymentStatus': paymentStatus,
        'id': id,
      };
}
