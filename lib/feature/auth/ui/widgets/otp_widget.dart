import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:memee/core/extensions/string_extension.dart';
import 'package:memee/core/extensions/theme_extension.dart';

import '../../../../core/widgets/textfields/app_pinfield.dart';
import '../../bloc/login_cubit.dart';
import '../../../../core/utils/app_di.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_strings.dart';
import 'login_header.dart';

class OTPWidget extends StatelessWidget {
  final Function(String) onCompleted;
  const OTPWidget({super.key, required this.onCompleted});

  @override
  Widget build(BuildContext context) {
    final loginCubit = locator.get<LoginCubit>();
    return Column(
      children: [
        LoginHeader(
          title: AppStrings.otpTitle,
          description:
              AppStrings.otpDescription.append(loginCubit.phoneNumber!),
        ),
        AppPinField(
          length: 6,
          onCompleted: (val) {
            if (val.isNotEmpty) {
              onCompleted(val);
            }
          },
        ),
        SizedBox(height: 16.h),
        Text(
          AppStrings.resend,
          style: Theme.of(context).textTheme.textMDMedium.copyWith(
                color: AppColors.textRegularColor,
              ),
        ),
      ],
    );
  }
}
