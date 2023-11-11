import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:memee/ui/__shared/extensions/widget_extensions.dart';

class LocationAppbar extends StatelessWidget implements PreferredSizeWidget {
  const LocationAppbar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: ListTile(
        title: Row(
          children: [
            Icon(
              Icons.home_filled,
              color: Theme.of(context).colorScheme.primary,
            ).gapRight(4.w),
            Text(
              'Home',
              style: Theme.of(context).textTheme.bodyLarge,
            ).gapRight(4.w),
            Icon(
              Icons.keyboard_arrow_down_outlined,
              color: Theme.of(context).colorScheme.primary,
            ),
          ],
        ),
        subtitle: Text(
          'No. 1, New Bangaru Naidu Colony,K.K. Nagar (West), Chennai - 600078',
          maxLines: 2,
          style: Theme.of(context).textTheme.bodySmall,
        ).paddingV(
          v: 4.h,
        ),
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(
        48.h,
      );
}
