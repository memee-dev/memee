import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:memee/core/shared/app_divider.dart';
import 'package:memee/ui/__shared/extensions/widget_extensions.dart';

class UserInformationWidget extends StatelessWidget {
  const UserInformationWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      title: Text(
        'Niyaz',
        style: Theme.of(context).textTheme.titleLarge,
      ),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 8.h),
          Row(
            children: [
              Icon(
                Icons.email_outlined,
                size: 16.sp,
                color: Theme.of(context).colorScheme.primary,
              ).gapRight(
                4.w,
              ),
              Expanded(
                child: Text(
                  'john.doe@example.com',
                  maxLines: 2,
                  style: Theme.of(context).textTheme.bodySmall,
                ).paddingV(
                  v: 4.h,
                ),
              ),
            ],
          ),
          Row(
            children: [
              Icon(
                Icons.phone,
                size: 16.sp,
                color: Theme.of(context).colorScheme.primary,
              ).gapRight(
                4.w,
              ),
              Expanded(
                child: Text(
                  '+1234567890',
                  style: Theme.of(context).textTheme.bodySmall,
                ),
              ),
            ],
          ).gapBottom(
            12.h,
          ),
          const AppDivider(),
        ],
      ),
      trailing: TextButton(
        onPressed: () {},
        child: Text(
          'Edit',
          style: Theme.of(context).textTheme.bodyLarge,
        ),
      ),
    );
  }
}
