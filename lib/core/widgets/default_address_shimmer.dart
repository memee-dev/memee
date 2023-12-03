import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:memee/core/extensions/widget_extensions.dart';
import 'package:shimmer/shimmer.dart';

class DefaultAddressShimmer extends StatelessWidget {
  const DefaultAddressShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey[200]!,
      highlightColor: Colors.grey[100]!,
      child: ListTile(
        title: Row(
          children: [
            const Icon(
              Icons.home_filled,
              color: Colors.grey,
            ).gapRight(4.w),
            Container(
              height: 8.h,
              width: 48.w,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(
                  8.r,
                ),
                color: Colors.grey, // Adjust color as needed
              ),
            ),
            const Icon(
              Icons.keyboard_arrow_down_outlined,
              color: Colors.grey,
            ),
          ],
        ),
        subtitle: Column(
          children: [
            Container(
              height: 8.h,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(
                  8.r,
                ),
                color: Colors.grey, // Adjust color as needed
              ),
            ).paddingV(4.w),
            Container(
              height: 8.h,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(
                  8.r,
                ),
                color: Colors.grey, // Adjust color as needed
              ),
            ).paddingV(4.h),
          ],
        ),
      ),
    );
  }
}
