import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';
import 'package:memee/core/extensions/widget_extensions.dart';
import 'package:memee/core/utils/app_assets.dart';

class LottieLocation extends StatelessWidget {
  final double? height;

  const LottieLocation({super.key, this.height});

  @override
  Widget build(BuildContext context) {
    return Lottie.asset(
      AppAssets.location,
      height: height ?? 36.h,
    ).gapRight(4.w);
  }
}
