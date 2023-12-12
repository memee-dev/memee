import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:memee/blocs/form/form_validation_cubit.dart';
import 'package:memee/core/blocs/refresh_cubit.dart';
import 'package:memee/blocs/user/user_cubit.dart';
import 'package:memee/core/extensions/theme_extension.dart';
import 'package:memee/core/utils/app_colors.dart';
import 'package:memee/core/utils/app_di.dart';
import 'package:memee/core/utils/app_router.dart';
import 'package:memee/core/utils/app_strings.dart';
import 'package:memee/core/extensions/widget_extensions.dart';
import 'package:memee/core/widgets/app_button.dart';

import '../../../../core/models/country_info_model.dart';
import '../../../../core/widgets/textfields/app_phonefield.dart';
import '../../../../core/widgets/textfields/app_textfield.dart';

class AddUserInfoScreen extends StatelessWidget {
  final dynamic map;

  const AddUserInfoScreen({
    super.key,
    this.map,
  });

  @override
  Widget build(BuildContext context) {
    final _formValidation = locator.get<FormValidationCubit>();
    final _userCubit = locator.get<UserCubit>();
    final phoneRefreshCubit = locator.get<RefreshCubit>();
    String selectedCountryCode = countryList.first.code;
    String phoneNumber = '';
    if (map['phoneNo'] != null) {
      if (map['phoneNo'].toString().startsWith(selectedCountryCode)) {
        phoneNumber =
            map['phoneNo'].toString().replaceFirst(selectedCountryCode, '');
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
        backgroundColor: AppColors.bgColor,
        title: Text(
          AppStrings.addUserInfo,
          style: Theme.of(context).textTheme.textLGMedium.copyWith(
                color: AppColors.displayColor,
              ),
        ),
        elevation: 0,
        leading: const BackButton(
          color: AppColors.displayColor,
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
          BlocBuilder<RefreshCubit, bool>(
            bloc: phoneRefreshCubit,
            builder: (context, state) {
              return AppPhoneTextField(
                controller: _phone,
                label: AppStrings.phoneHint,
                selectedCountryCode: selectedCountryCode,
                onChanged: (String? val) {
                  if (val != null) {
                    selectedCountryCode = val;
                  }
                },
              );
            },
          ).gapBottom(16.h),
          BlocConsumer<UserCubit, UserState>(
            bloc: _userCubit,
            builder: (context, state) {
              return AppButton.primary(
                text: 'Submit',
                onPressed: () {
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
                      phone: '$selectedCountryCode${_phone.text}',
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
          ).paddingV(8.h)
        ],
      ).paddingS(
        h: 16.w,
        v: 16.h,
      ),
    );
  }
}
