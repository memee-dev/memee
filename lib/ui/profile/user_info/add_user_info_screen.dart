import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:memee/blocs/form_cubit/form_validation_cubit.dart';
import 'package:memee/blocs/hide_and_seek/toggle_cubit.dart';
import 'package:memee/blocs/user/user_cubit.dart';
import 'package:memee/core/initializer/app_di.dart';
import 'package:memee/core/initializer/app_router.dart';
import 'package:memee/models/country_code_model.dart';
import 'package:memee/ui/__shared/extensions/widget_extensions.dart';
import 'package:memee/ui/__shared/widgets/app_button.dart';
import 'package:memee/ui/__shared/widgets/app_phonefield.dart';
import 'package:memee/ui/__shared/widgets/app_textfield.dart';

class AddUserInfoScreen extends StatelessWidget {
  final dynamic map;

  AddUserInfoScreen({
    super.key,
    this.map,
  });

  final _formValidation = locator.get<FormValidationCubit>();
  final _userCubit = locator.get<UserCubit>();
  final _toggleCubit = locator.get<ToggleCubit>();

  @override
  Widget build(BuildContext context) {
    CountryCodeModel selectedCountryCode = countryCodes.first;
    String phoneNumber = '';
    if (map['phoneNo'] != null) {
      if (map['phoneNo'].toString().startsWith(selectedCountryCode.code)) {
        phoneNumber = map['phoneNo']
            .toString()
            .replaceFirst(selectedCountryCode.code, '');
      }
    }
    final TextEditingController _name =
        TextEditingController(text: map['userName'] ?? '');
    final TextEditingController _email =
        TextEditingController(text: map['userEmail'] ?? '');
    final TextEditingController _phone =
        TextEditingController(text: phoneNumber);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Add User Info',
          style: Theme.of(context).textTheme.titleLarge,
        ),
      ),
      body: Column(
        children: [
          BlocBuilder<FormValidationCubit, FormValidationState>(
            bloc: _formValidation,
            builder: (context, state) {
              return AppTextField(
                controller: _name,
                label: 'User Name',
                errorText: state is UserNameEmpty ? state.message : null,
              ).gapBottom(12.h);
            },
          ),
          BlocBuilder<FormValidationCubit, FormValidationState>(
            bloc: _formValidation,
            builder: (context, state) {
              return AppTextField(
                controller: _email,
                label: 'Email',
                errorText: state is EmailEmpty ? state.message : null,
              ).gapBottom(12.h);
            },
          ),
          AppPhoneField(
            controller: _phone,
            cubit: _toggleCubit,
            selectedCountryCode: selectedCountryCode,
            onChanged: (CountryCodeModel? val) {
              if (val != null) {
                selectedCountryCode = val;
                _toggleCubit.change();
              }
            },
          ).gapBottom(16.h),
          BlocConsumer<UserCubit, UserState>(
            bloc: _userCubit,
            builder: (context, state) {
              return AppButton(
                label: 'Submit',
                isLoading: state is UserLoading,
                onTap: () {
                  FocusScope.of(context).unfocus();
                  if (_name.text.isEmpty) {
                    _formValidation.validateUserName(_name.text);
                    (_name.text);
                  } else if (_email.text.isEmpty) {
                    _formValidation.validateEmail(_email.text);
                  } else {
                    _userCubit.updateUserAddress(
                      name: _name.text,
                      email: _email.text,
                      phone: '${selectedCountryCode.code}${_phone.text}',
                    );
                  }
                },
              );
            },
            listener: (BuildContext context, UserState state) {
              if (state is UserUpdateSuccess) {
                Routes.pop(context);
              }
            },
          ).paddingV(
            v: 8.h,
          )
        ],
      ).paddingS(
        h: 16.w,
        v: 16.h,
      ),
    );
  }
}
