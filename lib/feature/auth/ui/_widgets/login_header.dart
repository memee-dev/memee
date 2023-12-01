import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:memee/core/extensions/theme_extension.dart';

import '../../../../core/utils/app_colors.dart';

class LoginHeader extends StatelessWidget {
  final String title;
  final String description;

  const LoginHeader({
    super.key,
    required this.title,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          title,
          style: Theme.of(context).textTheme.displayXSSemibold,
        ),
        SizedBox(height: 8.h),
        Text(
          description,
          style: Theme.of(context).textTheme.textMDRegular.copyWith(
                color: AppColors.textLightColor,
              ),
        ),
        SizedBox(height: 16.h),
      ],
    );
  }
}
