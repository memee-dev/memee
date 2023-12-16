import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:memee/blocs/user/user_cubit.dart';
import 'package:memee/core/extensions/theme_extension.dart';
import 'package:memee/core/extensions/widget_extensions.dart';
import 'package:memee/core/utils/app_bar.dart';
import 'package:memee/core/utils/app_colors.dart';
import 'package:memee/core/utils/app_di.dart';
import 'package:memee/core/utils/app_router.dart';
import 'package:memee/core/utils/app_strings.dart';
import 'package:memee/core/widgets/app_divider.dart';
import 'package:memee/core/widgets/default_address_shimmer.dart';
import 'package:memee/core/widgets/lottie_location.dart';
import 'package:memee/feature/address/widgets/saved_address_item.dart';

class SavedAddressScreen extends StatelessWidget {
  const SavedAddressScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScaffoldTemplate(
      title: AppStrings.savedAddress,
      floatingActionButton: TextButton.icon(
        icon: Icon(
          Icons.add,
          color: AppColors.textAccentDarkColor,
          size: 24.r,
        ),
        style: ButtonStyle(
          shape: MaterialStatePropertyAll(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(
                12.r,
              ),
              side: const BorderSide(
                color: AppColors.textAccentDarkColor,
              ),
            ),
          ),
          backgroundColor: const MaterialStatePropertyAll(
            AppColors.bgColor,
          ),
        ),
        onPressed: () {
          Routes.push(context, Routes.addEditAddress, extra: {
            'edit': false,
          });
        },
        label: Text(
          AppStrings.addAddress,
          style: Theme.of(context).textTheme.textSMSemibold.copyWith(
                color: AppColors.textAccentDarkColor,
              ),
        ),
      ).gapBottom(16.h),
      body: const _SavedAddress(),
    );
  }
}

class _SavedAddress extends StatelessWidget {
  const _SavedAddress();

  @override
  Widget build(BuildContext context) {
    final _user = locator.get<UserCubit>();
    return BlocBuilder<UserCubit, UserState>(
      bloc: _user..getSavedAddress(),
      builder: (context, state) {
        if (state == UserState.loading) {
          return ListView.builder(
            itemBuilder: (_, i) {
              return const DefaultAddressShimmer().paddingS(
                v: 24.h,
                h: 16.w,
              );
            },
            itemCount: 4,
          );
        } else if (state == UserState.success) {
          return _user.currentUser?.defaultAddress != null
              ? ListView.separated(
                  padding: EdgeInsets.symmetric(
                    horizontal: 16.h,
                    vertical: 16.w,
                  ),
                  shrinkWrap: true,
                  itemBuilder: (_, i) {
                    return SavedAddressItem(
                      address: (_user.currentUser?.address ?? [])[i],
                    );
                  },
                  separatorBuilder: (_, i) => const AppDivider().paddingV(24.h),
                  itemCount: (_user.currentUser?.address ?? []).length,
                )
              : Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      LottieLocation(
                        height: 64.h,
                      ),
                      Text(
                        'No address found. \n Add new address to proceed',
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.textMDMedium,
                      ),
                    ],
                  ),
                );
        }

        return const SizedBox.shrink();
      },
    );
  }
}
