import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:memee/core/utils/app_firestore.dart';
import 'package:memee/core/utils/app_logger.dart';
import 'package:memee/feature/cart/bloc/cart_bloc/cart_cubit.dart';
import 'package:memee/models/user_model.dart';

import '../../core/utils/app_di.dart';

part 'user_state.dart';

class UserCubit extends Cubit<UserState> {
  final FirebaseAuth auth;
  final FirebaseFirestore db;

  UserCubit(this.auth, this.db) : super(UserInitial());

  late UserModel currentUser;

  Future<void> updateUserAddress({
    String landmark = '',
    bool setAsDefault = false,
    String? name,
    String? email,
    String? phone,
    String? street,
    String? houseNo,
    String? area,
    String? city,
    String? pinCode,
  }) async {
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
          List<Map<String, dynamic>> updatedAddress = [];
          if (address.isNotEmpty) {
            for (var element in address) {
              if (element['no'] != houseNo) {
                updatedAddress.add({
                  'area': area,
                  'city': city,
                  'pincode': pinCode,
                  'street': street,
                  'landmark': landmark,
                  'no': houseNo,
                  'type': 'Home',
                  'default': setAsDefault,
                });
              } else {
                element['area'] = area;
                element['city'] = city;
                element['pincode'] = pinCode;
                element['street'] = street;
                element['landmark'] = landmark;
                element['no'] = houseNo;
                element['type'] = 'Home';
                element['default'] = setAsDefault;
                updatedAddress.add(element);
              }
            }
          } else {
            updatedAddress.add({
              'area': area,
              'city': city,
              'pincode': pinCode,
              'street': street,
              'landmark': landmark,
              'no': houseNo,
              'type': 'Home',
              'default': setAsDefault,
            });
          }

          address.addAll(updatedAddress);
          final newData = {
            'phoneNumber': phone ?? data['phoneNumber'],
            'address': address,
            'verified': data['verified'] ?? false,
            'active': data['active'] ?? false,
            'userName': name ?? data['userName'],
            'email': email ?? data['email'],
          };

          await reference.doc(user.uid).update(newData);

          emit(UserUpdateSuccess(message: 'Success'));
        } else {
          emit(UserUpdateFailure(
              message: 'Failed to update user Data, please try again later'));
        }
      }
    } catch (e) {
      console.e(e);
    }
  }

  Future<void> getCurrentUserInfo() async {
    emit(UserInfoLoading());
    try {
      User? user = auth.currentUser;
      locator.get<CartCubit>().fetchCartItems();

      if (user != null) {
        DocumentSnapshot userDoc = await db
            .collection(AppFireStoreCollection.userDev)
            .doc(user.uid)
            .get();

        Map<String, dynamic> data = userDoc.data() as Map<String, dynamic>;
        List<AddressModel> address = [];
        if (data['address'] != null && data['address'].isNotEmpty) {
          address = List<AddressModel>.from(
              data['address'].map((x) => AddressModel.fromJson(x)));
          AddressModel? defaultAddress;
          for (var key in data['address']) {
            if (key['default']) {
              defaultAddress = AddressModel.fromJson(key);
            }
          }
          currentUser = UserModel(
            id: user.uid,
            address: address,
            defaultAddress: defaultAddress,
            phoneNumber: data['phoneNumber'],
            verified: data['verified'],
            userName: data['userName'],
            active: data['active'],
            email: data['email'],
          );
          emit(CurrentUserState(user: currentUser));
        } else {
          currentUser = UserModel(
            id: user.uid,
            address: address,
            phoneNumber: data['phoneNumber'] ?? '',
            verified: data['verified'] ?? false,
            userName: data['userName'] ?? '',
            active: data['active'] ?? true,
            email: data['email'] ?? '',
          );
          emit(CurrentUserState(user: currentUser));
        }
      }
    } catch (e) {
      console.e(e.toString());
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

        currentUser = UserModel(
          id: user.uid,
          address: newList,
          defaultAddress: newList.firstWhere((element) => element.defaultValue),
          phoneNumber: data['phoneNumber'],
          verified: data['verified'],
          userName: data['userName'],
          active: data['active'],
          email: data['email'],
        );

        emit(CurrentUserState(user: currentUser));
      }
    } catch (e) {
      console.e(e.toString());
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
          currentUser = UserModel(
            id: user.uid,
            address: address,
            defaultAddress:
                address.firstWhere((element) => element.defaultValue),
            phoneNumber: data['phoneNumber'],
            verified: data['verified'],
            userName: data['userName'],
            active: data['active'],
            email: data['email'],
          );

          emit(CurrentUserState(user: currentUser));
        } else {
          emit(CurrentUserState(
              user: UserModel(
            id: user.uid,
            address: [],
            phoneNumber: data['phoneNumber'] ?? '',
            verified: data['verified'] ?? false,
            userName: data['userName'] ?? '',
            active: data['active'] ?? true,
            email: data['email'] ?? '',
          )));
        }
      }
    } catch (e) {
      console.e(e);
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
            }

            if (element['no'] != address.no) {
              element['default'] = false;
            }
            newList.add(AddressModel.fromJson(element));
          }
          await reference.doc(user.uid).update({
            'address': addressList,
          });

          emit(CurrentUserState(
              user: UserModel(
            id: user.uid,
            address: newList,
            defaultAddress: address,
            phoneNumber: data['phoneNumber'] ?? '',
            verified: data['verified'] ?? false,
            userName: data['userName'] ?? '',
            active: data['active'] ?? true,
            email: data['email'] ?? '',
          )));
        }
      }
    } catch (e) {
      console.e(e.toString());
      emit(UserUpdateFailure(message: 'Unable to fetch address'));
    }
  }
}
