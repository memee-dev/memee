import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:memee/blocs/user/user_cubit.dart';
import 'package:memee/core/extensions/theme_extension.dart';
import 'package:memee/core/utils/app_colors.dart';
import 'package:memee/core/utils/app_di.dart';
import 'package:memee/core/utils/app_router.dart';
import 'package:memee/core/utils/app_strings.dart';
import 'package:memee/models/user_model.dart';
import 'package:memee/core/extensions/widget_extensions.dart';
import 'package:memee/core/widgets/confirmation_dialog.dart';

class SavedAddressItem extends StatelessWidget {
  final AddressModel address;
  final String? label;
  final VoidCallback? onEdit;

  SavedAddressItem({
    super.key,
    required this.address,
    this.onEdit,
    this.label,
  });

  final _userCubit = locator.get<UserCubit>();

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
              boxShadow: [
                BoxShadow(
                  blurRadius: 16.r,
                  color: AppColors.textLightColor.withOpacity(0.24),
                  blurStyle: BlurStyle.outer,
                )
              ],
            )
          : null,
      child: Stack(
        children: [
          ListTile(
            contentPadding: address.defaultValue
                ? EdgeInsets.all(
                    8.r,
                  )
                : EdgeInsets.zero,
            onTap: () {
              showCupertinoDialog(
                context: context,
                barrierDismissible: true,
                builder: (BuildContext context) {
                  return BlocBuilder<UserCubit, UserState>(
                    bloc: _userCubit,
                    builder: (context, state) {
                      return ConfirmationDialog(
                        description: address.defaultValue
                            ? AppStrings.editAddressContent
                            : AppStrings.setAsDefaultContent,
                        buttonLabel1: address.defaultValue
                            ? AppStrings.cancel
                            : AppStrings.setAsDefaultLabel,
                        buttonLabel2: AppStrings.editAddress,
                        positiveBtn: () {
                          if (address.defaultValue) {
                            Routes.push(context, Routes.addEditAddress, extra: {
                              'address': address,
                              'edit': true,
                            });
                          }
                          Routes.pop(context);
                        },
                        negativeBtn: () {
                          if (!address.defaultValue) {
                            _userCubit.setAsDefault(true, address);
                          }

                          Routes.pop(context);
                        },
                      );
                    },
                  );
                },
              );
            },
            subtitle: Row(
              children: [
                Icon(
                  Icons.home_filled,
                  size: 16.sp,
                  color: AppColors.accentPinkColor,
                ).gapRight(
                  4.w,
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        address.type,
                        style: Theme.of(context).textTheme.textSMBold.copyWith(
                              color: AppColors.accentPinkColor,
                            ),
                      ).paddingV(
                        4.h,
                      ),
                      Text(
                        a,
                        maxLines: 2,
                        style: Theme.of(context).textTheme.textSMSemibold,
                      ),
                    ],
                  ),
                ),
                SizedBox(width: 8.w),
              ],
            ).paddingH(8.w),
            trailing: const Text('').paddingV(8.h),
          ),
          Align(
            alignment: Alignment.topRight,
            child: InkWell(
              onTap: !address.defaultValue
                  ? () {
                      showCupertinoDialog(
                        context: context,
                        barrierDismissible: true,
                        builder: (BuildContext context) {
                          return BlocBuilder<UserCubit, UserState>(
                            bloc: _userCubit,
                            builder: (context, state) {
                              return ConfirmationDialog(
                                description: AppStrings.deleteConfirmation,
                                buttonLabel1: AppStrings.delete,
                                buttonLabel2: AppStrings.cancel,
                                positiveBtn: () {
                                  Routes.pop(context);
                                },
                                negativeBtn: () {
                                  Routes.pop(context);
                                  _userCubit.deleteAddress(address);
                                },
                              );
                            },
                          );
                        },
                      );
                    }
                  : null,
              child: Container(
                padding: EdgeInsets.symmetric(
                  horizontal: 12.w,
                  vertical: 8.h,
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
                  color: address.defaultValue
                      ? Theme.of(context).colorScheme.primary
                      : Colors.red,
                ),
                child: Text(
                  address.defaultValue ? 'DEFAULT' : 'DELETE',
                  style: Theme.of(context).textTheme.textSMBold.copyWith(
                        color: AppColors.bgColor,
                      ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
