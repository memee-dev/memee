import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:memee/core/extensions/theme_extension.dart';

import '../utils/app_colors.dart';

class AppButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final Color color;
  final double width;
  final double height;

  const AppButton.primary({
    super.key,
    required this.text,
    required this.onPressed,
    this.color = AppColors.primaryButtonColor,
    this.width = double.infinity,
    this.height = 50.0,
  });

  const AppButton.secondary({
    super.key,
    required this.text,
    required this.onPressed,
    this.color = AppColors.secondaryButtonColor,
    this.width = double.infinity,
    this.height = 50.0,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: color,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.r),
          ),
        ),
        child: Text(
          text,
          style: Theme.of(context).textTheme.textLGSemibold.copyWith(
                color: AppColors.textDarkColor,
              ),
        ),
      ),
    );
  }
}
