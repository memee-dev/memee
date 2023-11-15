import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:memee/core/shared/app_divider.dart';
import 'package:memee/ui/__shared/extensions/widget_extensions.dart';

class SettingsSection extends StatelessWidget {
  const SettingsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      title: Row(
        children: [
          Icon(
            Icons.settings,
            size: 16.sp,
            color: Theme.of(context).colorScheme.primary,
          ).gapRight(
            4.w,
          ),
          Text(
            'Settings',
            style: Theme.of(context).textTheme.titleLarge,
          ),
        ],
      ),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'SMS, Notification, delete account',
            style: Theme.of(context).textTheme.bodySmall,
          ).paddingV(
            v: 12.h,
          ),
          const AppDivider(),
        ],
      ),
      trailing: IconButton(
        onPressed: () {},
        icon: const Icon(
          Icons.arrow_right,
        ),
      ),
    );
  }
}
