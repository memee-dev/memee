import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:memee/core/extensions/theme_extension.dart';

import '../../../../core/blocs/refresh_cubit.dart';
import '../../../../core/models/country_info_model.dart';
import '../../../../core/widgets/textfields/app_phonefield.dart';
import '../../bloc/login_cubit.dart';
import '../../../../core/utils/app_di.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_strings.dart';
import '../../../../core/widgets/app_button.dart';
import 'login_header.dart';

class PhoneWidget extends StatelessWidget {
  const PhoneWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final phoneController = TextEditingController();
    final phoneRefreshCubit = locator.get<RefreshCubit>();
    final loginCubit = locator.get<LoginCubit>();
    String selectedCountryCode = countryList.first.code;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const LoginHeader(
          title: AppStrings.loginTitle,
          description: AppStrings.loginDescription,
        ),
        Text(
          AppStrings.phoneNumber,
          style: Theme.of(context).textTheme.textMDMedium.copyWith(
                color: AppColors.textDarkColor,
              ),
        ),
        SizedBox(height: 6.h),
        BlocBuilder<RefreshCubit, bool>(
          bloc: phoneRefreshCubit,
          builder: (_, state) {
            return AppPhoneTextField(
              controller: phoneController,
              label: AppStrings.phoneHint,
              autofocus: true,
              selectedCountryCode: selectedCountryCode,
              onChanged: (value) {
                selectedCountryCode = value!;
                phoneRefreshCubit.change();
              },
            );
          },
        ),
        SizedBox(height: 48.h),
        AppButton.primary(
          text: AppStrings.login,
          onPressed: () {
            final val = phoneController.text.trim();
            if (val.isNotEmpty) {
              loginCubit.verifyPhoneNumber('$selectedCountryCode$val');
            }
          },
        ),
        SizedBox(height: 12.h),
        Center(
          child: RichText(
            text: TextSpan(
              text: AppStrings.dontHaveAccount,
              style: Theme.of(context).textTheme.textMDMedium.copyWith(
                    color: AppColors.textLightColor,
                  ),
              children: [
                TextSpan(
                  text: AppStrings.clickHere,
                  style: Theme.of(context).textTheme.textMDMedium.copyWith(
                        color: AppColors.linkColor,
                      ),
                ),
              ],
            ),
          ),
        )
      ],
    );
  }
}
