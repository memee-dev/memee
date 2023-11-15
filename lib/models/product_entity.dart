import 'dart:convert';

ProductEntity productEntityFromJson(String str) =>
    ProductEntity.fromJson(json.decode(str));

String productEntityToJson(ProductEntity data) => json.encode(data.toJson());

class ProductEntity {
  List<Details>? details;
  String? pId;
  String? cId;
  String? image;
  String? description;
  String? pName;
  String? cName;

  ProductEntity(
      {this.details,
      this.pId,
      this.cId,
      this.image,
      this.description,
      this.pName,
      this.cName});

  ProductEntity.fromJson(Map<String, dynamic> json) {
    if (json['details'] != null) {
      details = <Details>[];
      json['details'].forEach((v) {
        details!.add(Details.fromJson(v));
      });
    }
    pId = json['pId'];
    cId = json['cId'];
    image = json['image'];
    description = json['description'];
    pName = json['pName'];
    cName = json['cName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (details != null) {
      data['details'] = details!.map((v) => v.toJson()).toList();
    }
    data['pId'] = pId;
    data['cId'] = cId;
    data['image'] = image;
    data['description'] = description;
    data['pName'] = pName;
    data['cName'] = cName;
    return data;
  }
}

class Details {
  int? dPrice;
  int? price;
  int? quantity;

  Details({this.dPrice, this.price, this.quantity});

  Details.fromJson(Map<String, dynamic> json) {
    dPrice = json['dPrice'];
    price = json['price'];
    quantity = json['quantity'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['dPrice'] = dPrice;
    data['price'] = price;
    data['quantity'] = quantity;
    return data;
  }
}
