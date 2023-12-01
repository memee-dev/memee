import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:memee/core/utils/app_strings.dart';
import 'package:memee/core/extensions/widget_extensions.dart';

class ProductItemFooter extends StatelessWidget {
  final String normalPrice, discountPrice, name, type, description;

  const ProductItemFooter({
    super.key,
    required this.normalPrice,
    required this.name,
    required this.description,
    required this.type,
    required this.discountPrice,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          name,
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
                color: Colors.black54,
                fontWeight: FontWeight.w900,
              ),
        ),
        Text(
          description,
          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: Colors.black,
                fontWeight: FontWeight.w500,
              ),
        ).paddingV(6.h),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              '$type / ',
              overflow: TextOverflow.ellipsis,
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: Colors.black54,
                    fontWeight: FontWeight.w900,
                  ),
            ),
            Text(
              '${AppStrings.rupee}$discountPrice \t',
              overflow: TextOverflow.ellipsis,
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: Colors.black,
                    fontWeight: FontWeight.w900,
                  ),
            ),
            Text(
              '${AppStrings.rupee}$normalPrice',
              overflow: TextOverflow.ellipsis,
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: Colors.red.shade800,
                    fontWeight: FontWeight.w900,
                    decoration: TextDecoration.lineThrough,
                  ),
            ),
            const Spacer(),
            Text(
              'View',
              style: Theme.of(context).textTheme.bodyLarge,
            )
          ],
        ),
      ],
    ).paddingS(
      v: 4.h,
      h: 12.w,
    );
  }
}
