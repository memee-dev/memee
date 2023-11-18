import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:memee/blocs/login/login_state.dart';
import 'package:memee/core/initializer/app_di.dart';
import 'package:memee/core/shared/app_strings.dart';
import 'package:memee/ui/__shared/extensions/widget_extensions.dart';
import 'package:memee/ui/__shared/widgets/otp_field.dart';

import '../../blocs/hide_and_seek/hide_and_seek_cubit.dart';
import '../../blocs/login/login_cubit.dart';
import '../__shared/widgets/app_button.dart';
import '../__shared/widgets/app_textfield.dart';
import '../__shared/widgets/utils.dart';

class LoginPage extends StatelessWidget {
  final TextEditingController _mobileController = TextEditingController();
  final HideAndSeekCubit hideAndSeekCubit = locator.get<HideAndSeekCubit>();
  final otpController = TextEditingController();

  LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'MEME',
            style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                  fontWeight: FontWeight.w900,
                ),
          ).paddingE(
            value: 24,
          ),
          Row(
            children: [
              Container(
                alignment: Alignment.center,
                padding: EdgeInsets.symmetric(
                  horizontal: 16.w,
                  vertical: 16.h,
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(
                    12.sp,
                  ),
                  border: Border.all(
                    color: Theme.of(context).colorScheme.secondary.withOpacity(
                          0.5,
                        ),
                  ),
                ),
                child: Text(
                  '+ 91',
                  style: Theme.of(context).textTheme.bodySmall,
                ),
              ).gapRight(
                16.w,
              ),
              Expanded(
                child: AppTextField(
                  controller: _mobileController,
                  label: AppStrings.number,
                  keyboardType: TextInputType.number,
                ),
              ),
            ],
          ).gapBottom(
            16.h,
          ),
          BlocConsumer<LoginCubit, LoginState>(
            listener: (_, state) {
              if (state is LoginInitial) {
                _mobileController.text = '';
              } else if (state is LoginFailure) {
                snackBar(context, state.message);
              } else if (state is OtpSuccess) {
                snackBar(context, state.message ?? '');
              }
            },
            builder: (_, state) {
              bool isLoading = false;
              if (state is LoginLoading) {
                isLoading = true;
              }

              return Column(
                children: [
                  if (state is OtpSuccess) ...[
                    OtpField(
                      otpController: otpController,
                    ),
                    SizedBox(height: 16.h),
                  ],
                  AppButton(
                    isLoading: isLoading,
                    label: AppStrings.login,
                    onTap: () {
                      if (state is OtpSuccess) {
                        locator.get<LoginCubit>().loginWithPhoneNumber(
                            otp: otpController.text,
                            verificationId: state.verificationId ?? '');
                      } else {
                        locator
                            .get<LoginCubit>()
                            .verifyPhoneNumber('+91${_mobileController.text}');
                      }

                      FocusScope.of(context).unfocus();
                    },
                  ),
                ],
              );
            },
          )
        ],
      ).paddingS(),
    );
  }
}
