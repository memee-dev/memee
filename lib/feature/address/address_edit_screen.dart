import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:memee/blocs/form/form_validation_cubit.dart';
import 'package:memee/blocs/user/user_cubit.dart';
import 'package:memee/core/blocs/refresh_cubit.dart';
import 'package:memee/core/extensions/widget_extensions.dart';
import 'package:memee/core/utils/app_bar.dart';
import 'package:memee/core/utils/app_di.dart';
import 'package:memee/core/utils/app_router.dart';
import 'package:memee/core/utils/app_strings.dart';
import 'package:memee/core/widgets/app_button.dart';
import 'package:memee/feature/address/widgets/set_as_default.dart';
import 'package:memee/models/user_model.dart';
import '../../core/widgets/textfields/app_textfield.dart';

class AddressEditScreen extends StatelessWidget {
  final dynamic map;

  AddressEditScreen({super.key, this.map});

  final TextEditingController name = TextEditingController();
  final TextEditingController email = TextEditingController();

  final _formValidation = locator.get<FormValidationCubit>();
  final userCubit = locator.get<UserCubit>();
  final hideCubit = locator.get<RefreshCubit>();

  @override
  Widget build(BuildContext context) {
    AddressModel? address = map['address'];
    TextEditingController street = TextEditingController(text: address?.street);
    TextEditingController houseNo = TextEditingController(text: address?.no);
    TextEditingController area = TextEditingController(text: address?.area);
    TextEditingController city = TextEditingController(text: address?.city);
    TextEditingController pinCode =
        TextEditingController(text: address?.pincode);
    TextEditingController landmark =
        TextEditingController(text: address?.landmark);

    return ScaffoldTemplate(
      title:
          map['edit'] ?? false ? AppStrings.editAddress : AppStrings.addAddress,
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(
          horizontal: 16.h,
          vertical: 16.h,
        ),
        child: Column(
          children: [
            BlocBuilder<FormValidationCubit, FormValidationState>(
              bloc: _formValidation,
              builder: (context, state) {
                return AppTextField(
                  controller: street,
                  label: 'Street',
                  onChanged: (value) {
                    _formValidation.validateStreet(value);
                  },
                  errorText: state is StreetEmpty ? state.message : null,
                ).gapBottom(12.h);
              },
            ),
            BlocBuilder<FormValidationCubit, FormValidationState>(
              bloc: _formValidation,
              builder: (context, state) {
                return AppTextField(
                  controller: houseNo,
                  label: 'House no/ Flat no/ Floor no',
                  onChanged: (value) {
                    _formValidation.validateHouseNo(value);
                  },
                  errorText: state is HouseNoEmpty ? state.message : null,
                ).gapBottom(12.h);
              },
            ),
            BlocBuilder<FormValidationCubit, FormValidationState>(
              bloc: _formValidation,
              builder: (context, state) {
                return AppTextField(
                  controller: area,
                  label: 'Area',
                  onChanged: (value) {
                    _formValidation.validateArea(value);
                  },
                  errorText: state is AreaEmpty ? state.message : null,
                ).gapBottom(12.h);
              },
            ),
            BlocBuilder<FormValidationCubit, FormValidationState>(
              bloc: _formValidation,
              builder: (context, state) {
                return AppTextField(
                  controller: city,
                  label: 'City',
                  onChanged: (value) {
                    _formValidation.validateCity(value);
                  },
                  errorText: state is CityEmpty ? state.message : null,
                ).gapBottom(12.h);
              },
            ),
            BlocBuilder<FormValidationCubit, FormValidationState>(
              bloc: _formValidation,
              builder: (context, state) {
                return AppTextField(
                  controller: pinCode,
                  label: 'pinCode',
                  onChanged: (value) {
                    _formValidation.validatePinCode(value);
                  },
                  errorText: state is PinCodeEmpty ? state.message : null,
                ).gapBottom(12.h);
              },
            ),
            AppTextField(
              controller: landmark,
              label: 'Landmark (Optional)',
            ).gapBottom(12.h),
            BlocBuilder<RefreshCubit, bool>(
              bloc: hideCubit,
              builder: (context, state) {
                return SetAsDefaultWidget(
                  isChecked: address?.defaultValue ?? state,
                  onChanged: (bool? value) {
                    address?.defaultValue = state;
                    hideCubit.change();
                  },
                );
              },
            ),
            BlocListener<UserCubit, UserState>(
              bloc: userCubit,
              child: AppButton.primary(
                text: 'Submit Address',
                onPressed: () {
                  if (street.text.isEmpty) {
                    _formValidation.validateStreet(street.text);
                  } else if (houseNo.text.isEmpty) {
                    _formValidation.validateHouseNo(houseNo.text);
                  } else if (area.text.isEmpty) {
                    _formValidation.validateArea(area.text);
                  } else if (city.text.isEmpty) {
                    _formValidation.validateCity(city.text);
                  } else if (pinCode.text.isEmpty) {
                    _formValidation.validatePinCode(pinCode.text);
                  } else {
                    if (map['edit'] == true) {
                      userCubit.updateUserAddress(
                        street: street.text,
                        houseNo: houseNo.text,
                        area: area.text,
                        pinCode: pinCode.text,
                        city: city.text,
                        landmark: landmark.text,
                        setAsDefault: address?.defaultValue ?? false,
                      );
                    } else {
                      userCubit.addNewAddress(
                        street: street.text,
                        houseNo: houseNo.text,
                        area: area.text,
                        pinCode: pinCode.text,
                        city: city.text,
                        landmark: landmark.text,
                        setAsDefault: address?.defaultValue ?? hideCubit.state,
                      );
                    }
                  }
                },
              ),
              listener: (BuildContext context, UserState state) {
                if (state == UserState.userDataUpdate && map['edit'] == false) {
                  Routes.pop(context);
                  userCubit.getSavedAddress();
                }
              },
            ).paddingV(8.h)
          ],
        ),
      ),
    );
  }
}
