import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:memee/ui/__shared/extensions/widget_extensions.dart';

class CartAddressWidget extends StatelessWidget {
  const CartAddressWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(
          Icons.home_filled,
          size: 16.sp,
          color: Theme.of(context).colorScheme.secondary,
        ).gapRight(
          4.w,
        ),
        Expanded(
          flex: 1,
          child: Text(
            'Home',
            maxLines: 2,
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).colorScheme.secondary,
                ),
          ).gapRight(
            4.w,
          ),
        ),
        Expanded(
          flex: 3,
          child: Text(
            'No. 1, New Bangaru Naidu Colony,K.K. Nagar (West), Chennai - 600078',
            maxLines: 2,
            style: Theme.of(context).textTheme.bodySmall,
          ).paddingV(
            v: 4.h,
          ),
        )
      ],
    ).paddingH(
      h: 16.w,
    );
  }
}
