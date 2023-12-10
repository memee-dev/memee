import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:memee/core/extensions/string_extension.dart';
import 'package:memee/core/extensions/theme_extension.dart';
import 'package:memee/core/extensions/widget_extensions.dart';
import 'package:memee/core/utils/app_colors.dart';
import 'package:memee/core/widgets/app_divider.dart';

class ProfileItem extends StatelessWidget {
  final String title, subtitle;
  final IconData icon;
  final IconData? trailingIcon;
  final GestureTapCallback? onPressed;

  const ProfileItem({
    super.key,
    required this.title,
    required this.subtitle,
    required this.icon,
    this.trailingIcon,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onPressed,
      contentPadding: EdgeInsets.zero,
      title: Row(
        children: [
          Icon(
            icon,
            size: 16.sp,
            color: AppColors.textAccentDarkColor,
          ).gapRight(
            4.w,
          ),
          Text(
            title.toCapitalize(),
            style: Theme.of(context).textTheme.textLGSemibold,
          ),
        ],
      ),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            subtitle,
            style: Theme.of(context).textTheme.textSMSemibold.copyWith(
                  color: AppColors.textLightColor,
                ),
          ).paddingV(12.h),
          const AppDivider(color: AppColors.textAccentDarkColor),
        ],
      ),
      trailing: Icon(
        trailingIcon ?? Icons.arrow_right,
        size: 24.sp,
        color: AppColors.textAccentDarkColor,
      ),
    );
  }
}
