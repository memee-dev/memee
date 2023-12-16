import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:memee/core/extensions/theme_extension.dart';
import 'package:memee/core/extensions/widget_extensions.dart';
import 'package:memee/core/utils/app_colors.dart';
import 'package:memee/core/utils/app_router.dart';
import 'package:memee/core/utils/app_strings.dart';
import 'package:memee/core/widgets/add_edit_icon_button.dart';
import 'package:memee/core/widgets/lottie_location.dart';
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

    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            address != null
                ? Text(
                    AppStrings.orderWillBeDeliveredTo,
                    style: Theme.of(context).textTheme.textSMSemibold,
                  )
                : Container(),
          ],
        ).gapBottom(8.h),
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(
              12.r,
            ),
            boxShadow: [
              BoxShadow(
                color: AppColors.displayColor.withOpacity(
                  0.25,
                ),
                blurRadius: 16.r,
                blurStyle: BlurStyle.outer,
              ),
            ],
            color: AppColors.bgColor,
          ),
          child: Row(
            children: [
              const LottieLocation(),
              Expanded(
                flex: 1,
                child: Text(
                  address != null ? userAddress : AppStrings.addDeliveryAddress,
                  maxLines: 2,
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
          ).paddingS(v: 8.h, h: 8.w),
        ),
      ],
    ).gapBottom(16.h);
  }
}
