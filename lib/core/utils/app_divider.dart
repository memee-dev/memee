import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:memee/core/utils/app_colors.dart';

class AppDivider extends StatelessWidget {
  final double? height;
  final double? width;

  const AppDivider({super.key, this.height, this.width});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width ?? MediaQuery.of(context).size.width * 0.75,
      child: Divider(
        color: Theme.of(context).colorScheme.primary,
        thickness: 2.sp,
        height: (height ?? 4).h,
      ),
    );
  }
}

class AppBackButton extends StatelessWidget {
  const AppBackButton({super.key});

  @override
  Widget build(BuildContext context) {
    return const BackButton(
      color: AppColors.displayColor,
    );
  }
}
