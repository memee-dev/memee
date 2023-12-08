import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:memee/core/extensions/widget_extensions.dart';
import 'package:shimmer/shimmer.dart';

class ProductItemShimmer extends StatelessWidget {
  const ProductItemShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey[200]!,
      highlightColor: Colors.grey[100]!,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(
            12.r,
          ),
          boxShadow: [
            BoxShadow(
              blurStyle: BlurStyle.outer,
              color: Colors.black12,
              blurRadius: 16.r,
            )
          ],
          color: Colors.white38,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: MediaQuery.of(context).size.height * 0.24,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(
                  12.r,
                ),
                color: Colors.grey.shade500, // Adjust color as needed
              ),
            ).gapBottom(4.h),
            Container(
              height: 8.h,
              width: MediaQuery.of(context).size.width * 0.16,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(
                  8.r,
                ),
                color: Colors.grey, // Adjust color as needed
              ),
              margin: EdgeInsets.symmetric(horizontal: 12.w),
            ).gapBottom(4.h),
            Container(
              height: 8.h,
              width: MediaQuery.of(context).size.width * 0.36,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(
                  8.r,
                ),
                color: Colors.grey, // Adjust color as needed
              ),
              margin: EdgeInsets.symmetric(horizontal: 12.w),
            ).gapBottom(4.h),
            Row(
              children: [
                Expanded(
                  child: Container(
                    height: 8.h,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(
                        8.r,
                      ),
                      color: Colors.grey, // Adjust color as needed
                    ),
                    margin: EdgeInsets.symmetric(horizontal: 12.w),
                  ).gapRight(48.w),
                ),
                Container(
                  height: 8.h,
                  width: MediaQuery.of(context).size.width * 0.16,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(
                      8.r,
                    ),
                    color: Colors.grey, // Adjust color as needed
                  ),
                  margin: EdgeInsets.symmetric(horizontal: 12.w),
                )
              ],
            ).gapBottom(4.h),
          ],
        ),
      ),
    );
  }
}
