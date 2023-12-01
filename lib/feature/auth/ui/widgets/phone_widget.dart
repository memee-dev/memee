import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:memee/core/extensions/theme_extension.dart';

import '../../bloc/login_cubit.dart';
import '../../../../core/utils/app_di.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_strings.dart';
import '../../../../core/widgets/app_button.dart';
import '../../../../core/widgets/app_textfield.dart';
import 'login_header.dart';

class PhoneWidget extends StatelessWidget {
  const PhoneWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final phoneQIDController = TextEditingController();
    final loginCubit = locator.get<LoginCubit>();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const LoginHeader(
          title: AppStrings.loginTitle,
          description: AppStrings.loginDescription,
        ),
        Text(
          AppStrings.phoneNumber,
          style: Theme.of(context).textTheme.textMDRegular.copyWith(
                color: AppColors.textDarkColor,
              ),
        ),
        SizedBox(height: 6.h),
        AppTextField(
          controller: phoneQIDController,
          label: AppStrings.phoneHint,
          inputFormatters: <TextInputFormatter>[
            LengthLimitingTextInputFormatter(10),
            FilteringTextInputFormatter.allow(RegExp(r'^\+?\d*$')),
          ],
        ),
        SizedBox(height: 48.h),
        AppButton.primary(
          text: AppStrings.login,
          onPressed: () {
            final val = phoneQIDController.text.trim();
            if (val.isNotEmpty) {
              loginCubit.verifyPhoneNumber('+91$val');
            }
          },
        ),
      ],
    );
  }
}
