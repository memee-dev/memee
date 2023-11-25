import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:memee/core/shared/app_firestore.dart';
import 'package:memee/core/shared/app_logger.dart';
import 'package:memee/models/user_model.dart';

part 'user_state.dart';

class UserCubit extends Cubit<UserState> {
  final FirebaseAuth auth;
  final FirebaseFirestore db;

  UserCubit(this.auth, this.db) : super(UserInitial());

  late UserModel currentUser;
  late AddressModel defaultAddress;

  Future<void> updateUserAddress(String street, houseNo, area, city, pinCode,
      {String landmark = '', bool setAsDefault = false}) async {
    emit(UserLoading());
    try {
      User? user = auth.currentUser;
      CollectionReference reference =
          db.collection(AppFireStoreCollection.userDev);

      if (user != null) {
        DocumentSnapshot userDoc = await db
            .collection(AppFireStoreCollection.userDev)
            .doc(user.uid)
            .get();

        if (userDoc.exists) {
          Map<String, dynamic> data = userDoc.data() as Map<String, dynamic>;
          List<Map<String, dynamic>> address =
              List<Map<String, dynamic>>.from(data['address'] ?? []);

          for (var element in address) {
            if (setAsDefault && element['no'] != houseNo) {
              element['default'] = false;
            }
            if (setAsDefault && element['no'] != houseNo) {
              element['area'] = area;
              element['city'] = city;
              element['pincode'] = pinCode;
              element['street'] = street;
              element['landmark'] = landmark;
              element['houseNo'] = houseNo;
              element['type'] = 'Home';
              element['default'] = setAsDefault;
            }
          }

          final newData = {
            'phoneNumber': data['phoneNumber'],
            'address': address,
            'verified': data['verified'],
            'active': data['active'],
            'userName': data['userName'],
            'email': data['email'],
          };

          await reference.doc(user.uid).update(newData);

          emit(UserUpdateSuccess(message: 'Success'));
        } else {
          emit(UserUpdateFailure(
              message: 'Failed to update user Data, please try again later'));
        }
      }
    } catch (e) {
      emit(UserUpdateFailure(
          message: 'Failed to update user Data, please try again later'));
    }
  }

  Future<void> getDefaultAddress() async {
    emit(UserLoading());
    try {
      User? user = auth.currentUser;

      if (user != null) {
        DocumentSnapshot userDoc = await db
            .collection(AppFireStoreCollection.userDev)
            .doc(user.uid)
            .get();

        Map<String, dynamic> data = userDoc.data() as Map<String, dynamic>;

        if (data['address'].isNotEmpty) {
          for (var key in data['address']) {
            if (key['default']) {
              defaultAddress = AddressModel.fromJson(key);
              emit(UserDefaultAddressState(address: defaultAddress));
            } else {
              final list = List<AddressModel>.from(
                  data['address'].map((x) => AddressModel.fromJson(x)));
              defaultAddress = list.first;
              emit(UserDefaultAddressState(address: defaultAddress));
            }
          }
        }
      }
    } catch (e) {
      log.e(e.toString());
    }
  }

  Future<void> deleteAddress(AddressModel address) async {
    emit(UserLoading());
    try {
      User? user = auth.currentUser;
      CollectionReference reference =
          db.collection(AppFireStoreCollection.userDev);
      if (user != null) {
        DocumentSnapshot userDoc = await db
            .collection(AppFireStoreCollection.userDev)
            .doc(user.uid)
            .get();

        Map<String, dynamic> data = userDoc.data() as Map<String, dynamic>;
        List<AddressModel> newList = [];

        if (data['address'].isNotEmpty) {
          List<Map<String, dynamic>> updatedAddressList =
              List<Map<String, dynamic>>.from(data['address']);

          for (int i = 0; i < updatedAddressList.length; i++) {
            if (updatedAddressList[i]['no'] == address.no) {
              updatedAddressList.remove(updatedAddressList[i]);
            }

            if (updatedAddressList.isNotEmpty) {
              newList.add(AddressModel.fromJson(updatedAddressList[i]));
              await reference.doc(user.uid).update({
                'address': updatedAddressList,
              });
            }
          }
        }

        emit(SavedAddressState(address: newList));
      }
    } catch (e) {
      log.e(e.toString());
      emit(UserUpdateFailure(message: 'Unable to delete address'));
    }
  }

  Future<void> getSavedAddress() async {
    emit(UserLoading());
    try {
      User? user = auth.currentUser;

      if (user != null) {
        DocumentSnapshot userDoc = await db
            .collection(AppFireStoreCollection.userDev)
            .doc(user.uid)
            .get();

        List<AddressModel> address = [];
        Map<String, dynamic> data = userDoc.data() as Map<String, dynamic>;
        address = List<AddressModel>.from(
            data['address'].map((x) => AddressModel.fromJson(x)));
        if (address.isNotEmpty) {
          defaultAddress = address.first;
          emit(SavedAddressState(address: address));
        } else {
          emit(SavedAddressState(address: const []));
        }
      }
    } catch (e) {
      log.e(e);
      emit(UserUpdateFailure(message: 'No address found'));
    }
  }

  Future<void> setAsDefault(bool value, AddressModel address) async {
    emit(UserLoading());
    try {
      User? user = auth.currentUser;
      CollectionReference reference =
          db.collection(AppFireStoreCollection.userDev);
      if (user != null) {
        DocumentSnapshot userDoc = await db
            .collection(AppFireStoreCollection.userDev)
            .doc(user.uid)
            .get();

        if (userDoc.exists) {
          Map<String, dynamic> data = userDoc.data() as Map<String, dynamic>;
          List<Map<String, dynamic>> addressList =
              List<Map<String, dynamic>>.from(data['address'] ?? []);

          List<AddressModel> newList = [];
          for (var element in addressList) {
            if (element['no'] == address.no) {
              element['default'] = value;
              defaultAddress = AddressModel.fromJson(element);
            }

            if (element['no'] != address.no) {
              element['default'] = false;
            }
            newList.add(AddressModel.fromJson(element));
          }
          await reference.doc(user.uid).update({
            'address': addressList,
          });
          emit(SavedAddressState(address: newList));
        }
      }
    } catch (e) {
      log.e(e.toString());
      emit(UserUpdateFailure(message: 'Unable to fetch address'));
    }
  }
}
