import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:memee/core/extensions/theme_extension.dart';
import 'package:memee/core/extensions/widget_extensions.dart';
import 'package:memee/core/utils/app_router.dart';
import 'package:memee/core/utils/app_strings.dart';
import 'package:memee/core/widgets/add_edit_icon_button.dart';
import 'package:memee/models/user_model.dart';

class CartAddressWidget extends StatelessWidget {
  final AddressModel? address;
  final bool isEmpty;

  const CartAddressWidget({
    super.key,
    this.address,
    required this.isEmpty,
  });

  @override
  Widget build(BuildContext context) {
    String userAddress =
        '${address?.no}, ${address?.street}, ${address?.area}, ${address?.city}, ${address?.pincode}, ${address?.landmark}';

    return Row(
      children: [
        Expanded(
          flex: 1,
          child: Text(
            address != null ? userAddress : AppStrings.addDeliveryAddress,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: Theme.of(context).textTheme.textSMMedium,
          ),
        ),
        Expanded(
          flex: 0,
          child: AddEditIcon(
            onTap: () {
              if (isEmpty) {
                Routes.push(context, Routes.addEditAddress,
                    extra: {'edit': false});
              } else {
                Routes.push(context, Routes.savedAddress);
              }
            },
            addIcon: isEmpty,
          ),
        ),
      ],
    ).paddingS(v: 8.h, h: 8.w);
  }
}
