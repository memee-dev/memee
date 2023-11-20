import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:memee/core/shared/app_firestore.dart';
import 'package:memee/models/user_model.dart';

part 'user_state.dart';

class UserCubit extends Cubit<UserState> {
  final FirebaseAuth auth;
  final FirebaseFirestore db;

  UserCubit(this.auth, this.db) : super(UserInitial());

  late AddressModel address;

  updateUserAddress(String street, houseNo, area, city, pinCode,
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
            if (setAsDefault) {
              element['default'] = false;
            }
          }

          address.add({
            'area': area,
            'city': city,
            'pincode': pinCode,
            'street': street,
            'landmark': landmark,
            'default': setAsDefault,
            'type': 'Home',
            'no': houseNo,
          });

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

  getDefaultAddress() async {
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
              address = AddressModel.fromJson(key);
              emit(UserDefaultAddressState(address: address));
            }
          }
        }
      }
    } catch (e) {
      emit(UserUpdateFailure(message: 'Unable to fetch address'));
    }
  }

  deleteAddress(AddressModel address) async {
    emit(SavedAddressState(address: const []));
    emit(SavedAddressLoading());
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

          for (var key in updatedAddressList) {
            if (key['street'] == address.street) {
              updatedAddressList.remove(key);

              await reference.doc(user.uid).update({
                'address': updatedAddressList,
              });
              newList.add(AddressModel.fromJson(key));
              emit(SavedAddressState(address: newList));
            }
          }
        }
      }
    } catch (e) {
      emit(UserUpdateFailure(message: 'Unable to delete address'));
    }
  }

  getSavedAddress() async {
    emit(SavedAddressState(address: const []));
    emit(SavedAddressLoading());
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
          emit(SavedAddressState(address: address));
        }
      }
    } catch (e) {
      emit(UserUpdateFailure(message: 'No address found'));
    }
  }
}
