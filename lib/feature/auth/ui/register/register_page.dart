import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:memee/core/extensions/widget_extensions.dart';
import 'package:memee/feature/auth/bloc/register_cubit.dart';

import '../../../../core/utils/app_di.dart';
import '../../../../core/utils/app_colors.dart';
import '../_widgets/otp_widget.dart';
import '../_widgets/phone_widget.dart';

class RegisterPage extends StatelessWidget {
  const RegisterPage({super.key});

  @override
  Widget build(BuildContext context) {
    final registerCubit = locator.get<RegisterCubit>();
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
                      BlocBuilder<RegisterCubit, RegisterState>(
                        bloc: registerCubit,
                        builder: (_, state) {
                          return state != RegisterState.phoneNumber
                              ? IconButton(
                                  onPressed: () => registerCubit.back(),
                                  icon: const Icon(Icons.arrow_back_ios),
                                )
                              : const SizedBox.shrink();
                        },
                      ),
                    ],
                  ).paddingV(24.h),
                  BlocBuilder<RegisterCubit, RegisterState>(
                    bloc: registerCubit,
                    builder: (_, state) {
                      if (state == RegisterState.phoneNumber) {
                        return const PhoneWidget();
                      } else if (state == RegisterState.otp) {
                        return OTPWidget(
                          onCompleted: (String? val) {},
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
