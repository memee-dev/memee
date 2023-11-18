import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppDivider extends StatelessWidget {
  final double? height;

  const AppDivider({super.key, this.height});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.75,
      child: Divider(
        color: Theme.of(context).colorScheme.primary,
        thickness: 2.sp,
        height: (height ?? 4).h,
      ),
    );
  }
}
