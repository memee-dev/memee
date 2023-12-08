import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:memee/core/extensions/theme_extension.dart';

import '../../../../core/utils/app_textinputformatter.dart';
import '../../../../core/widgets/textfields/app_textfield.dart';
import '../../bloc/login_cubit.dart';
import '../../../../core/utils/app_di.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_strings.dart';
import '../../../../core/widgets/app_button.dart';
import 'login_header.dart';

class RegisterWidget extends StatelessWidget {
  const RegisterWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final nameController = TextEditingController();
    final emailController = TextEditingController();
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
          controller: nameController,
          label: AppStrings.nameHint,
          inputFormatters: <TextInputFormatter>[
            LengthLimitingTextInputFormatter(10),
            FilteringTextInputFormatter.allow(RegExp(r'^\+?\d*$')),
          ],
        ),
        SizedBox(height: 4.h),
        AppTextField(
          controller: emailController,
          label: AppStrings.emailHint,
          inputFormatters: <TextInputFormatter>[
            EmailInputFormatter(),
          ],
        ),
        SizedBox(height: 48.h),
        AppButton.primary(
          text: AppStrings.login,
          onPressed: () {
            final name = nameController.text.trim();
            final email = emailController.text.trim();
            if (name.isNotEmpty && email.isNotEmpty) {
              loginCubit.register(name, email);
            }
          },
        ),
        SizedBox(height: 12.h),
        Center(
          child: RichText(
            text: TextSpan(
              text: AppStrings.dontHaveAccount,
              style: Theme.of(context).textTheme.textMDRegular.copyWith(
                    color: AppColors.textLightColor,
                  ),
              children: [
                TextSpan(
                  text: AppStrings.clickHere,
                  style: Theme.of(context).textTheme.textMDRegular.copyWith(
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
