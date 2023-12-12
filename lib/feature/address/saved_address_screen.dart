import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:memee/blocs/user/user_cubit.dart';
import 'package:memee/core/extensions/theme_extension.dart';
import 'package:memee/core/extensions/widget_extensions.dart';
import 'package:memee/core/utils/app_bar.dart';
import 'package:memee/core/utils/app_colors.dart';
import 'package:memee/core/utils/app_di.dart';
import 'package:memee/core/widgets/app_divider.dart';
import 'package:memee/core/utils/app_router.dart';
import 'package:memee/core/utils/app_strings.dart';
import 'package:memee/core/widgets/default_address_shimmer.dart';
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
          AppStrings.addNewAddress,
          style: Theme.of(context).textTheme.textSMSemibold.copyWith(
                color: AppColors.textAccentDarkColor,
              ),
        ),
      ).gapBottom(16.h),
      body: BlocProvider.value(
        value: locator.get<UserCubit>(),
        child: const _SavedAddress(),
      ),
    );
  }
}

class _SavedAddress extends StatelessWidget {
  const _SavedAddress();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserCubit, UserState>(
      bloc: locator.get<UserCubit>()..getSavedAddress(),
      builder: (context, state) {
        if (state is UserLoading) {
          return ListView.builder(
            itemBuilder: (_, i) {
              return const DefaultAddressShimmer().paddingS(
                v: 24.h,
                h: 16.w,
              );
            },
            itemCount: 4,
          );
        } else if (state is CurrentUserState) {
          return ListView.separated(
            padding: EdgeInsets.symmetric(
              horizontal: 16.h,
              vertical: 16.w,
            ),
            shrinkWrap: true,
            itemBuilder: (_, i) {
              return SavedAddressItem(
                address: (state.user.address ?? [])[i],
                onEdit: () {
                  Routes.push(context, Routes.addEditAddress, extra: {
                    'edit': false,
                    'address': (state.user.address ?? [])[i],
                  });
                },
              );
            },
            separatorBuilder: (_, i) => const AppDivider().paddingV(24.h),
            itemCount: (state.user.address ?? []).length,
          );
        }

        return const SizedBox.shrink();
      },
    );
  }
}
