import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

extension Template on Widget {
  Widget paddingH([double? h]) => Padding(
        padding: EdgeInsets.symmetric(horizontal: h ?? 16.w),
        child: this,
      );
  Widget paddingV([double? v]) => Padding(
        padding: EdgeInsets.symmetric(vertical: v ?? 8.h),
        child: this,
      );
  Widget paddingALL([double? value]) => Padding(
        padding: EdgeInsets.all(value ?? 16.r),
        child: this,
      );
  Widget paddingS({double? h, double? v}) => Padding(
        padding: EdgeInsets.symmetric(
          horizontal: h ?? 16.w,
          vertical: v ?? 12.w,
        ),
        child: this,
      );

  Widget show(bool show) => show ? this : const SizedBox.shrink();

  Widget gapTop(double value) => Padding(
        padding: EdgeInsets.only(top: value),
        child: this,
      );
  Widget gapBottom(double value) => Padding(
        padding: EdgeInsets.only(bottom: value),
        child: this,
      );

  Widget gapRight(double value) => Padding(
        padding: EdgeInsets.only(right: value),
        child: this,
      );
  Widget gapLeft(double value) => Padding(
        padding: EdgeInsets.only(left: value),
        child: this,
      );

  Widget flexible({int flex = 1}) => Flexible(
        flex: flex,
        child: this,
      );
}
