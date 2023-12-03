import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:memee/core/extensions/theme_extension.dart';
import 'package:memee/core/extensions/widget_extensions.dart';
import 'package:memee/core/utils/app_colors.dart';

class HelpSection extends StatelessWidget {
  const HelpSection({super.key});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      title: Row(
        children: [
          Icon(
            Icons.help,
            size: 16.sp,
            color: AppColors.accentPinkColor,
          ).gapRight(
            4.w,
          ),
          Text(
            'Help',
            style: Theme.of(context).textTheme.textLGBold,
          ),
        ],
      ),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Raise Queries, contact us',
            style: Theme.of(context).textTheme.textSMSemibold.copyWith(
                  color: AppColors.textLightColor,
                ),
          ).paddingV(12.h),
        ],
      ),
      trailing: IconButton(
        onPressed: () {},
        icon: Icon(
          Icons.arrow_right,
          size: 16.sp,
          color: AppColors.accentPinkColor,
        ),
      ),
    );
  }
}
