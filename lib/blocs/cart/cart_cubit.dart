import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:memee/core/utils/app_firestore.dart';
import 'package:memee/core/utils/app_logger.dart';
import 'package:memee/models/cart_model.dart';
import 'package:memee/models/product_model.dart';

part 'cart_state.dart';

class CartCubit extends Cubit<CartState> {
  final FirebaseFirestore db;
  final FirebaseAuth auth;

  CartCubit(this.auth, this.db) : super(CartLoading());

  final collectionName = AppFireStoreCollection.cart;

  void fetchCartItems() async {
    emit(CartLoading());
    final List<CartModel> cartItems = [];
    try {
      final userId = auth.currentUser!.uid;
      final cartDoc = await db
          .collection(AppFireStoreCollection.userDev)
          .doc(userId)
          .collection(collectionName)
          .get();

      final docs = cartDoc.docs;

      for (var doc in docs) {
        final data = doc.data();
        data['id'] = doc.id;
        cartItems.add(CartModel.fromMap(data));
      }
      emit(CartSuccess(cartItems: cartItems));
    } catch (e) {
      console.e(e);
      emit(CartFailure(message: e.toString(), cartItems: cartItems));
    }
  }

  Future<void> addProduct(
    ProductDetailsModel details,
    String productId,
    String productName,
    String productImg,
  ) async {
    final List<CartModel> cartItems = getLocalCartItems();
    try {
      final userId = auth.currentUser!.uid;
      final ref = db
          .collection(AppFireStoreCollection.userDev)
          .doc(userId)
          .collection(collectionName);

      if (cartItems.isNotEmpty) {
        CartModel? _cartModel;

        for (var item in cartItems) {
          if (item.productId == productId) {
            _cartModel = item;
          }
        }

        if (_cartModel != null) {
          final index = cartItems.indexOf(_cartModel);
          final selectedItemIndex = _cartModel.selectedItems
              .indexWhere((element) => element.productDetails == details);

          if (selectedItemIndex != -1) {
            _cartModel.selectedItems[selectedItemIndex].units++;
          } else {
            _cartModel.selectedItems
                .add(SelectedItemModel(units: 1, productDetails: details));
          }
          await ref.doc(_cartModel.id).update(_cartModel.toJson());
          cartItems[index] = _cartModel;
        } else {
          _cartModel = CartModel(
            productId: productId,
            name: productName,
            image: productImg,
            selectedItems: [
              SelectedItemModel(units: 1, productDetails: details)
            ],
          );
          final docRef = await ref.doc().get();
          _cartModel.id = docRef.id;
          await ref.doc(_cartModel.id).set(_cartModel.toJson());
          cartItems.add(_cartModel);
        }
      } else {
        final _cartModel = CartModel(
          productId: productId,
          name: productName,
          image: productImg,
          selectedItems: [
            SelectedItemModel(
              units: 1,
              productDetails: details,
            ),
          ],
        );

        final docRef = await ref.add(_cartModel.toJson());
        _cartModel.id = docRef.id;
        cartItems.add(_cartModel);
      }
      emit(CartLoading());
      emit(CartSuccess(cartItems: cartItems));
    } catch (e) {
      console.e(e);
      emit(CartFailure(message: e.toString(), cartItems: cartItems));
    }
  }

  Future<void> removeProduct(
      ProductDetailsModel details, String productId) async {
    final cartItems = getLocalCartItems();
    try {
      final userId = auth.currentUser!.uid;
      final ref = db
          .collection(AppFireStoreCollection.userDev)
          .doc(userId)
          .collection(collectionName);

      if (cartItems.isNotEmpty) {
        final CartModel _cartModel =
            cartItems.firstWhere((item) => item.productId == productId);
        final cartIndex = cartItems.indexOf(_cartModel);
        final selectedItemIndex = _cartModel.selectedItems
            .indexWhere((element) => element.productDetails == details);
        if (selectedItemIndex >= 0) {
          _cartModel.selectedItems[selectedItemIndex].units--;
          if (_cartModel.selectedItems[selectedItemIndex].units <= 0) {
            _cartModel.selectedItems.removeAt(selectedItemIndex);
          }
          if (_cartModel.selectedItems.isEmpty) {
            ref.doc(_cartModel.id).delete();
            cartItems.removeAt(cartIndex);
          } else {
            await ref.doc(_cartModel.id).update(_cartModel.toJson());
            cartItems[cartIndex] = _cartModel;
          }
        }
      }

      emit(CartLoading());
      emit(CartSuccess(cartItems: cartItems));
    } catch (e) {
      emit(CartLoading());
      emit(CartFailure(message: '', cartItems: cartItems));
      console.e(e);
    }
  }

  int showQty(ProductDetailsModel details, String productId) {
    final cartItems = getLocalCartItems();
    try {
      final cIndex =
          cartItems.indexWhere((item) => item.productId == productId);
      final selectedItemIndex = cartItems[cIndex]
          .selectedItems
          .indexWhere((element) => element.productDetails == details);
      return cartItems[cIndex].selectedItems[selectedItemIndex].units;
    } catch (e) {
      return 0;
    }
  }

  List<CartModel> getLocalCartItems() {
    List<CartModel> cartItems = [];
    if (state is CartResponseState) {
      cartItems.addAll((state as CartResponseState).cartItems);
    }
    return cartItems;
  }

  String getTotalAmount(String productId) {
    List<CartModel> cartItems = [];
    double totalAmount = 0.0;
    if (state is CartResponseState) {
      cartItems.addAll((state as CartResponseState).cartItems);
    }

    if (productId.isNotEmpty) {
      final cart =
          cartItems.firstWhere((element) => element.productId == productId);
      for (var item in cart.selectedItems) {
        totalAmount +=
            (item.units * item.productDetails.discountedPrice).toDouble();
      }
    } else {
      for (var cart in cartItems) {
        for (var item in cart.selectedItems) {
          totalAmount +=
              (item.units * item.productDetails.discountedPrice).toDouble();
        }
      }
    }
    return totalAmount.toStringAsFixed(2);
  }
}
