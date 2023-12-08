class UserModel {
  UserModel({
    this.address,
    required this.id,
    required this.phoneNumber,
    this.verified = true,
    this.active = true,
    required this.userName,
    required this.email,
    this.defaultAddress,
  });

  List<AddressModel>? address;
  String phoneNumber;
  String id;
  bool verified;
  bool active;
  String userName;
  String email;
  AddressModel? defaultAddress;

  factory UserModel.fromJson(Map<dynamic, dynamic> json) => UserModel(
        id: json['id'],
        userName: json['userName'],
        email: json['email'],
        phoneNumber: json['phoneNumber'],
        verified: json['verified'],
        active: json['active'],
        address: json['address'] != null
            ? List<AddressModel>.from(
                json['address'].map((x) => AddressModel.fromJson(x)))
            : null,
      );

  Map<String, dynamic> toJson() => {
        'address': address != null
            ? List<Map<String, dynamic>>.from(address!.map((x) => x.toJson()))
            : null,
        'phoneNumber': phoneNumber,
        'verified': verified,
        'id': id,
        'active': active,
        'userName': userName,
        'email': email,
      };
}

class AddressModel {
  AddressModel({
    required this.area,
    required this.pincode,
    required this.no,
    required this.defaultValue,
    required this.city,
    required this.street,
    required this.landmark,
    required this.type,
  });

  String area;
  String pincode;
  String no;
  bool defaultValue;
  String city;
  String street;
  String landmark;
  String type;

  factory AddressModel.fromJson(Map<dynamic, dynamic> json) => AddressModel(
        area: json['area'],
        pincode: json['pincode'],
        no: json['no'],
        defaultValue: json['default'],
        city: json['city'],
        street: json['street'],
        landmark: json['landmark'],
        type: json['type'],
      );

  Map<String, dynamic> toJson() => {
        'area': area,
        'pincode': pincode,
        'no': no,
        'default': defaultValue,
        'city': city,
        'street': street,
        'landmark': landmark,
        'type': type,
      };

  String addressString() => '$no, $street, $area, $city, $pincode, $landmark';
}
