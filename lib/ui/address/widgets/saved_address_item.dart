import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:memee/models/user_model.dart';
import 'package:memee/ui/__shared/extensions/widget_extensions.dart';

class SavedAddressItem extends StatelessWidget {
  final AddressModel address;
  final String? label;
  final VoidCallback? onEdit;

  const SavedAddressItem({
    super.key,
    required this.address,
    this.onEdit,
    this.label,
  });

  @override
  Widget build(BuildContext context) {
    String a =
        '${address.no},${address.street},${address.area},${address.city},${address.pincode},${address.landmark}';
    return Container(
      decoration: address.defaultValue
          ? BoxDecoration(
              borderRadius: BorderRadius.circular(
                12.r,
              ),
              border: Border.all(
                color: Theme.of(context).colorScheme.primary,
              ),
            )
          : null,
      child: Stack(
        children: [
          ListTile(
            contentPadding: EdgeInsets.zero,
            title: Row(
              children: [
                Expanded(
                  child: Text(
                    'Home',
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                ),
              ],
            ).paddingH(
              h: 16.w,
            ),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
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
                        a,
                        maxLines: 2,
                        style: Theme.of(context).textTheme.bodySmall,
                      ).paddingV(
                        v: 4.h,
                      ),
                    ),
                  ],
                )
                    .gapBottom(
                      12.h,
                    )
                    .paddingH(
                      h: 8.w,
                    ),
              ],
            ),
            trailing: TextButton(
              onPressed: onEdit,
              child: Text(
                label ?? 'Edit',
                style: Theme.of(context).textTheme.bodyLarge,
              ),
            ).paddingV(
              v: 8.h,
            ),
          ),
          address.defaultValue
              ? Align(
                  alignment: Alignment.topRight,
                  child: Container(
                    padding: EdgeInsets.all(
                      6.r,
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(
                          12.r,
                        ),
                        topRight: Radius.circular(
                          12.r,
                        ),
                      ),
                      color: Theme.of(context).colorScheme.primary,
                    ),
                    child: Text(
                      'DEFAULT',
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                  ),
                )
              : const SizedBox.shrink(),
        ],
      ),
    );
  }
}
