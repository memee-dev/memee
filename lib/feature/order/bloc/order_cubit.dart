import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:memee/core/extensions/string_extension.dart';
import 'package:memee/core/utils/app_firestore.dart';
import 'package:memee/core/utils/app_logger.dart';
import 'package:memee/core/utils/app_strings.dart';
import 'package:memee/models/order_model.dart';

part 'order_state.dart';

class OrderCubit extends Cubit<OrderState> {
  final FirebaseFirestore db;

  OrderCubit(this.db) : super(OrderInitial());

  updateOrderList(data) async {
    emit(OrderLoading());
    int lastNumber = 0;
    try {
      final ordersDoc = db.collection(AppFireStoreCollection.orders);

      final doc =
          await ordersDoc.orderBy('id', descending: true).limit(1).get();

      if (doc.docs.isNotEmpty) {
        lastNumber = int.parse(doc.docs.first['id'].substring(2));
      }

      int nextNumber = lastNumber + 1;
      String formattedProductNumber = nextNumber.toString().padLeft(4, '0');
      String orderId = 'O-${formattedProductNumber.padLeft(4, '0')}';

      data['id'] = orderId;

      await ordersDoc.doc(orderId).set(data);
    } catch (e) {
      console.e(e);
    }
  }

  getOrders() async {
    emit(OrderLoading());
    List<OrderModel> orders = [];

    try {
      final ordersDoc =
          await db.collection(AppFireStoreCollection.orders).get();

      if (ordersDoc.docs.isNotEmpty) {
        for (var doc in ordersDoc.docs) {
          final data = doc.data();
          data['id'] = doc.id;

          orders.add(OrderModel.fromJson(data));
        }
      }
      emit(OrderSuccess(orders: orders));
    } catch (e) {
      emit(OrderSuccess(orders: orders));
      console.e(e);
    }
  }

  cancelOder(OrderModel order) async {
    emit(OrderLoading());
    List<OrderModel> orders = [];
    try {
      final collection = db.collection(AppFireStoreCollection.orders);

      final ordersDoc = await collection.get();

      if (ordersDoc.docs.isNotEmpty) {
        for (var doc in ordersDoc.docs) {
          final data = doc.data();
          orders.add(OrderModel.fromJson(data));
        }
      }
      if (orders.isNotEmpty) {
        for (OrderModel item in orders) {
          if (order.id == item.id) {
            item.updatedTime = DateTime.now().format();
            item.orderStatus = AppStrings.orderCancelled;

            await collection.doc(order.id).update(item.toJson());
          }
        }
      }
      emit(OrderSuccess(orders: orders, updated: true));
    } catch (e) {
      emit(OrderSuccess(orders: orders));
      console.e(e);
    }
  }

  List<OrderModel> getLocalOrders() {
    List<OrderModel> orders = [];

    if (state is OrderSuccess) {
      orders.addAll((state as OrderSuccess).orders);
    }
    return orders;
  }
}
