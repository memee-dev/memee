part of 'user_cubit.dart';

abstract class UserState extends Equatable {
  @override
  List<Object> get props => [];
}

class UserInitial extends UserState {}

class UserLoading extends UserState {}

class UserUpdateFailure extends UserState {
  final String message;

  UserUpdateFailure({required this.message});
}

class UserUpdateSuccess extends UserState {
  final String message;

  UserUpdateSuccess({required this.message});
}

class UserDefaultAddressState extends UserState {
  final AddressModel address;

  UserDefaultAddressState({required this.address});
}

class SavedAddressLoading extends UserState {}
class DeleteAddressLoading extends UserState {}

class SavedAddressState extends UserState {
  final List<AddressModel> address;

  SavedAddressState({required this.address});
}
