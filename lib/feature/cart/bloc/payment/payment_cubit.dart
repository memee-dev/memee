import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:memee/blocs/utility/utility_cubit.dart';
import 'package:memee/blocs/user/user_cubit.dart';
import 'package:memee/core/extensions/string_extension.dart';
import 'package:memee/core/utils/app_di.dart';
import 'package:memee/core/utils/app_firestore.dart';
import 'package:memee/core/utils/app_logger.dart';
import 'package:memee/core/utils/app_strings.dart';
import 'package:memee/feature/cart/bloc/cart_bloc/cart_cubit.dart';
import 'package:memee/feature/order/bloc/order_cubit.dart';
import 'package:memee/models/cart_model.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

part 'payment_state.dart';

class PaymentCubit extends Cubit<PaymentState> {
  final FirebaseFirestore db;
  final FirebaseAuth auth;

  PaymentCubit(this.db, this.auth) : super(PaymentInitial());

  final Razorpay _razorpay = Razorpay();
  final _cart = locator.get<CartCubit>();
  final _user = locator.get<UserCubit>();
  final _order = locator.get<OrderCubit>();
  final _slot = locator.get<UtilityCubit>();

  init() {
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
  }

  openCheckout(options) async {
    try {
      _razorpay.open(options);
    } on Exception catch (e) {
      console.e(e);
    }
  }

  Future<void> _handlePaymentSuccess(PaymentSuccessResponse response) async {
    emit(PaymentInitial());
    final List<CartModel> cartItems = await getLocalCartItems();
    try {
      Map<String, dynamic> map = {
        'orders': cartItems.map((e) => e.toJson()).toList(),
        'orderedTime': DateTime.now().format(),
        'updatedTime': DateTime.now().format(),
        'paymentStatus': response.paymentId != null ? 'Success' : 'Failed',
        'totalAmount': _cart.getTotalAmount(''),
        'orderStatus': AppStrings.orderPending,
        'paymentId': response.paymentId,
        'userId': _user.currentUser?.id,
        'address': _user.currentUser?.defaultAddress?.addressString(),
        'timeSlot': _slot.selectedTime,
      };
      await _order.updateOrderList(map);

      console.i(map);
      await deleteCartItemOnSuccess();
      emit(PaymentSuccess(paymentId: response.paymentId!));
    } catch (e) {
      console.e(e);
    }
  }

  _handlePaymentError(PaymentFailureResponse response) async {
    try {
      if (response.code != 2) {
        List<CartModel> cartItems = await getLocalCartItems();

        Map<String, dynamic> map = {
          'orders': cartItems.map((e) => e.toJson()).toList(),
          'orderedTime': DateTime.now().format(),
          'updatedTime': DateTime.now().format(),
          'paymentStatus': response.message ?? 'Failed',
          'orderStatus': 'Order Failed',
          'totalAmount': _cart.getTotalAmount(''),
          'paymentId': 'NA',
          'userId': _user.currentUser?.id,
          'address': _user.currentUser?.defaultAddress?.addressString(),
          'timeSlot': _slot.selectedTime,
        };

        _order.updateOrderList(map);
        await deleteCartItemOnSuccess();
        emit(PaymentFailure(response: response));
      }
    } catch (e) {
      console.e(e);
    }
  }

  Future<void> _handleExternalWallet(ExternalWalletResponse response) async {
    emit(PaymentInitial());
    try {
      List<CartModel> cartItems = await getLocalCartItems();

      Map<String, dynamic> map = {
        'orders': cartItems.map((e) => e.toJson()).toList(),
        'orderedTime': DateTime.now().format(),
        'updatedTime': DateTime.now().format(),
        'paymentStatus': 'Payment Failed with ${response.walletName}',
        'orderStatus': 'Order Failed',
        'totalAmount': _cart.getTotalAmount(''),
        'paymentId': 'NA',
        'userId': _user.currentUser?.id,
        'address': _user.currentUser?.defaultAddress?.addressString(),
        'timeSlot': _slot.selectedTime,
      };
      _order.updateOrderList(map);
      await deleteCartItemOnSuccess();
      emit(PaymentWalletFailure(
          message:
              'There seems to be a problem with the ${response.walletName} wallet payment processing. Please try again later.'));
    } catch (e) {
      console.e(e);
    }
  }

  Future<List<CartModel>> getLocalCartItems() async {
    List<CartModel> cartItems = [];
    try {
      final userId = auth.currentUser!.uid;
      final cartDoc = await db
          .collection(AppFireStoreCollection.userDev)
          .doc(userId)
          .collection(AppFireStoreCollection.cart)
          .get();

      final docs = cartDoc.docs;

      for (var doc in docs) {
        final data = doc.data();
        cartItems.add(CartModel.fromMap(data));
      }
    } catch (e) {
      console.e(e);
      return cartItems;
    }
    return cartItems;
  }

  deleteCartItemOnSuccess() async {
    final userId = auth.currentUser!.uid;
    final cartDoc = await db
        .collection(AppFireStoreCollection.userDev)
        .doc(userId)
        .collection(AppFireStoreCollection.cart)
        .get();

    for (var doc in cartDoc.docs) {
      await doc.reference.delete();
    }
  }
}
