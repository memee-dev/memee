import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:memee/blocs/user/user_cubit.dart';
import 'package:memee/core/initializer/app_di.dart';
import 'package:memee/core/initializer/app_router.dart';
import 'package:memee/core/shared/app_strings.dart';
import 'package:memee/models/user_model.dart';
import 'package:memee/ui/__shared/extensions/widget_extensions.dart';
import 'package:memee/ui/__shared/widgets/confirmation_dialog.dart';

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
              border: Border.all(
                color: Theme.of(context).colorScheme.primary,
              ),
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
                            ? AppStrings.setAsDefault
                            : AppStrings.editAddress,
                        buttonLabel1: address.defaultValue
                            ? AppStrings.setAsDefaultLabel
                            : AppStrings.cancel,
                        buttonLabel2: AppStrings.editAddressLabel,
                        onConfirm: () {
                          Routes.pop(context);
                        },
                        onCancel: () {
                          // Routes.appGoRouter(context, Routes.editAddress,
                          //     extra: address);

                          Routes.pop(context);
                        },
                      );
                    },
                  );
                },
              );
            },
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
                    SizedBox(width: 8.w),
                  ],
                ).paddingH(
                  h: 8.w,
                ),
              ],
            ),
            trailing: const Text('').paddingV(
              v: 8.h,
            ),
          ),
          Align(
            alignment: Alignment.topRight,
            child: InkWell(
              onTap: () {
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
                          onConfirm: () {
                            Routes.pop(context);
                            _userCubit.deleteAddress(address);
                          },
                          onCancel: () {
                            // Routes.appGoRouter(context, Routes.editAddress,
                            //     extra: address);

                            Routes.pop(context);
                          },
                        );
                      },
                    );
                  },
                );
              },
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
                  style: Theme.of(context).textTheme.bodySmall,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
