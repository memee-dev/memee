import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:memee/blocs/form_cubit/form_validation_cubit.dart';
import 'package:memee/blocs/hide_and_seek/hide_and_seek_cubit.dart';
import 'package:memee/blocs/user/user_cubit.dart';
import 'package:memee/core/initializer/app_di.dart';
import 'package:memee/ui/__shared/extensions/widget_extensions.dart';
import 'package:memee/ui/__shared/widgets/app_button.dart';
import 'package:memee/ui/__shared/widgets/app_textfield.dart';
import 'package:memee/ui/address/widgets/map_widget.dart';
import 'package:memee/ui/address/widgets/set_as_default.dart';

class AddressEditScreen extends StatelessWidget {
  AddressEditScreen({super.key});

  final TextEditingController street = TextEditingController();
  final TextEditingController houseNo = TextEditingController();
  final TextEditingController area = TextEditingController();
  final TextEditingController city = TextEditingController();
  final TextEditingController pinCode = TextEditingController();
  final TextEditingController landmark = TextEditingController();
  final formValidation = locator.get<FormValidationCubit>();
  final userCubit = locator.get<UserCubit>();
  final hideCubit = locator.get<HideAndSeekCubit>();

  @override
  Widget build(BuildContext context) {
    //context.read<UserCubit>().updateUserAddress();
    String streetError = '';
    String homeError = '';
    String pinCodeError = '';
    String areaError = '';
    bool formValid = false;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Edit Address',
          style: Theme.of(context).textTheme.titleLarge,
        ),
        leading: const BackButton(),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(
          horizontal: 16.h,
          vertical: 16.h,
        ),
        child: Column(
          children: [
            MapWidget(),
            BlocConsumer<FormValidationCubit, FormValidationState>(
              listener: (BuildContext context, FormValidationState state) {
                if (state is FormValidationInitial) {
                } else if (state is StreetEmpty) {
                  streetError = state.message ?? '';
                } else if (state is HouseNoEmpty) {
                  homeError = state.message ?? '';
                } else if (state is PinCodeEmpty) {
                  pinCodeError = state.message ?? '';
                } else if (state is AreaEmpty) {
                  areaError = state.message ?? '';
                } else if (state is FormSubmit) {
                  formValid = state.valid;
                }
              },
              bloc: formValidation,
              builder: (context, state) {
                return Form(
                  key: formValidation.formKey,
                  child: Column(
                    children: [
                      AppTextField(
                        controller: street,
                        label: 'Street',
                        validator: (value) =>
                            formValidation.validateStreet(value ?? ''),
                        errorText: streetError,
                      ),
                      AppTextField(
                        controller: houseNo,
                        label: 'House no/ Flat no/ Floor no',
                        validator: (value) =>
                            formValidation.validateHouseNo(value ?? ''),
                        errorText: homeError,
                      ).paddingV(
                        v: 8.h,
                      ),
                      AppTextField(
                        controller: area,
                        label: 'Area',
                        validator: (value) =>
                            formValidation.validateArea(value ?? ''),
                        errorText: areaError,
                      ),
                      AppTextField(
                        controller: city,
                        label: 'City',
                        validator: (value) =>
                            formValidation.validateCity(value ?? ''),
                        errorText: areaError,
                      ),
                      AppTextField(
                        controller: pinCode,
                        label: 'pinCode',
                        validator: (value) =>
                            formValidation.validatePinCode(value ?? ''),
                        errorText: pinCodeError,
                      ).paddingV(
                        v: 8.h,
                      ),
                      AppTextField(
                        controller: landmark,
                        label: 'Landmark (Optional)',
                      ).gapBottom(4.h),
                      BlocBuilder<HideAndSeekCubit, bool>(
                        bloc: hideCubit,
                        builder: (context, state) {
                          return SetAsDefaultWidget(
                            isChecked: state,
                            onChanged: (bool? value) {
                              hideCubit.change();
                            },
                          );
                        },
                      ),
                      BlocBuilder<UserCubit, UserState>(
                        bloc: userCubit,
                        builder: (context, state) {
                          return AppButton(
                            label: 'Submit Address',
                            isLoading: state is UserLoading,
                            onTap: () {
                              formValidation.checkValidation();
                              if (formValid) {
                                userCubit.updateUserAddress(
                                  street.text,
                                  houseNo.text,
                                  area.text,
                                  pinCode.text,
                                  city.text,
                                  landmark: landmark.text,
                                  setAsDefault: hideCubit.state,
                                );
                              }
                            },
                          );
                        },
                      ).paddingV(
                        v: 8.h,
                      )
                    ],
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
