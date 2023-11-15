import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:memee/ui/__shared/extensions/widget_extensions.dart';

class HelpSection extends StatelessWidget {
  const HelpSection({super.key});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      title: Row(
        children: [
          Icon(
            Icons.help_outline,
            size: 16.sp,
            color: Theme.of(context).colorScheme.primary,
          ).gapRight(
            4.w,
          ),
          Text(
            'Help',
            style: Theme.of(context).textTheme.titleLarge,
          ),
        ],
      ),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Raise Queries, contact us',
            style: Theme.of(context).textTheme.bodySmall,
          ).paddingV(
            v: 12.h,
          ),
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
