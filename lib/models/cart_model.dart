import 'package:memee/models/product_model.dart';

class CartModel {
  String? id;
  final String productId;
  final List<SelectedItemModel> selectedItems;

  CartModel({
    this.id,
    required this.productId,
    required this.selectedItems,
  });

  factory CartModel.fromMap(Map<String, dynamic> map) {
    return CartModel(
      id: map['id'],
      productId: map['productId'],
      selectedItems: List<SelectedItemModel>.from(
          map['selectedItems'].map((x) => SelectedItemModel.fromMap(x))),
    );
  }

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['productId'] = productId;
    if (selectedItems.isNotEmpty) {
      map['selectedItems'] = List<Map<String, dynamic>>.from(
        selectedItems.map((x) => x.toJson()),
      );
    }
    return map;
  }
}

class SelectedItemModel {
  int units;
  final ProductDetailsModel productDetails;

  SelectedItemModel({required this.units, required this.productDetails});

  factory SelectedItemModel.fromMap(Map<String, dynamic> map) {
    return SelectedItemModel(
      units: map['units'],
      productDetails: ProductDetailsModel.fromMap(map['productDetails']),
    );
  }

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['units'] = units;
    map['productDetails'] = productDetails.toJson();
    return map;
  }
}
