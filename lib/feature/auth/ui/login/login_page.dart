import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:memee/core/extensions/widget_extensions.dart';

import '../../bloc/login_cubit.dart';
import '../../../../core/utils/app_di.dart';
import '../../../../core/utils/app_colors.dart';
import '../_widgets/otp_widget.dart';
import '../_widgets/phone_widget.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    final loginCubit = locator.get<LoginCubit>();
    final size = ScreenUtil();
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          Container(
            width: size.screenWidth,
            padding: EdgeInsets.only(top: 32.h),
            decoration: const BoxDecoration(color: AppColors.accentDarkColor),
          ),
          Positioned(
            bottom: 0.h,
            child: Container(
              height: size.screenHeight * 0.7,
              width: size.screenWidth,
              decoration: BoxDecoration(
                color: AppColors.bgColor,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(32.r),
                  topRight: Radius.circular(32.r),
                ),
              ),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      BlocBuilder<LoginCubit, LoginState>(
                        bloc: loginCubit,
                        builder: (_, state) {
                          return state != LoginState.phoneNumber
                              ? IconButton(
                                  onPressed: () => loginCubit.back(),
                                  icon: const Icon(Icons.arrow_back_ios),
                                )
                              : const SizedBox.shrink();
                        },
                      ),
                    ],
                  ).paddingV(24.h),
                  BlocBuilder<LoginCubit, LoginState>(
                    bloc: loginCubit,
                    builder: (_, state) {
                      if (state == LoginState.phoneNumber) {
                        return const PhoneWidget();
                      } else if (state == LoginState.otp) {
                        return OTPWidget(
                          onCompleted: (String? val) {
                            loginCubit.verifyOTP(val!);
                          },
                        );
                      }
                      return const SizedBox.shrink();
                    },
                  ),
                ],
              ).paddingH(24.w),
            ),
          ),
        ],
      ),
    );
  }
}
