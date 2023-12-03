import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:memee/core/extensions/theme_extension.dart';
import 'package:memee/core/utils/app_colors.dart';
import 'package:memee/core/utils/app_router.dart';
import 'package:memee/core/utils/app_divider.dart';
import 'package:memee/core/utils/app_strings.dart';
import 'package:memee/models/user_model.dart';
import 'package:memee/core/extensions/widget_extensions.dart';

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
            style: Theme.of(context).textTheme.textLGBold,
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
                  style: Theme.of(context).textTheme.textSMSemibold.copyWith(
                        color: AppColors.textLightColor,
                      ),
                ).paddingV(4.h),
              ),
            ],
          ).gapBottom(
            12.h,
          ),
          const AppDivider(),
        ],
      ),
      trailing: IconButton(
        onPressed: () => Routes.push(context, Routes.savedAddress),
        icon: Icon(
          Icons.edit,
          color: AppColors.accentPinkColor,
          size: 24.r,
        ),
      ),
    );
  }
}

class NoAddressFound extends StatelessWidget {
  const NoAddressFound({super.key});

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
            AppStrings.savedAddress,
            style: Theme.of(context).textTheme.textLGBold,
          ),
        ],
      ),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 8.h),
          Expanded(
            child: Text(
              AppStrings.noAddressFound,
              maxLines: 2,
              style: Theme.of(context).textTheme.textSMSemibold,
            ).paddingV(4.h),
          ).gapBottom(
            12.h,
          ),
          const AppDivider(),
        ],
      ),
      trailing: TextButton(
        onPressed: () => Routes.push(context, Routes.addEditAddress, extra: {
          'edit': false,
        }),
        child: Text(
          AppStrings.add,
          style: Theme.of(context).textTheme.textLGBold,
        ),
      ),
    );
  }
}
