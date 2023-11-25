import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:memee/blocs/user/user_cubit.dart';
import 'package:memee/core/initializer/app_di.dart';
import 'package:memee/core/initializer/app_router.dart';
import 'package:memee/core/shared/app_divider.dart';
import 'package:memee/models/user_model.dart';
import 'package:memee/ui/__shared/extensions/widget_extensions.dart';

class SavedAddressesSection extends StatelessWidget {
  final AddressModel address;

  const SavedAddressesSection({super.key, required this.address});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      title: Row(
        children: [
          Icon(
            Icons.bookmark_added_rounded,
            size: 16.sp,
            color: Theme.of(context).colorScheme.primary,
          ).gapRight(
            4.w,
          ),
          Text(
            'Saved Addresses',
            style: Theme.of(context).textTheme.titleLarge,
          ),
        ],
      ),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 8.h),
          Row(
            children: [
              Icon(
                Icons.home_filled,
                size: 16.sp,
                color: Theme.of(context).colorScheme.primary,
              ).gapRight(
                4.w,
              ),
              Expanded(
                child: Text(
                  '${address.no},${address.street},${address.area},${address.city},${address.pincode},${address.landmark}',
                  maxLines: 2,
                  style: Theme.of(context).textTheme.bodySmall,
                ).paddingV(
                  v: 4.h,
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
        onPressed: () => Routes.push(context, Routes.savedAddress),
        child: Text(
          'Edit',
          style: Theme.of(context).textTheme.bodyLarge,
        ),
      ),
    );
  }
}
