import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:memee/core/extensions/theme_extension.dart';
import 'package:memee/core/extensions/widget_extensions.dart';

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
    return ListTile(
      title: Text(
        title,
        textAlign: TextAlign.center,
        style: Theme.of(context).textTheme.displayXSMedium,
      ).gapBottom(16.h),
      subtitle: Text(
        description,
        style: Theme.of(context).textTheme.textSMMedium.copyWith(
              color: AppColors.textLightColor,
            ),
      ).gapBottom(16.h),
    );
  }
}
