import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:memee/blocs/user/user_cubit.dart';
import 'package:memee/core/extensions/widget_extensions.dart';
import 'package:memee/core/utils/app_bar.dart';
import 'package:memee/core/utils/app_di.dart';
import 'package:memee/core/utils/app_divider.dart';
import 'package:memee/core/utils/app_router.dart';
import 'package:memee/core/utils/app_strings.dart';
import 'package:memee/core/widgets/default_address_shimmer.dart';
import 'package:memee/feature/address/widgets/saved_address_item.dart';

class SavedAddressScreen extends StatelessWidget {
  const SavedAddressScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppbarTemplate(
        title: AppStrings.savedAddress,
      ),
      floatingActionButton: TextButton.icon(
        icon: const Icon(
          Icons.add,
        ),
        style: ButtonStyle(
          shape: MaterialStatePropertyAll(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(
                12.r,
              ),
              side: BorderSide(
                color: Theme.of(context).colorScheme.primary,
              ),
            ),
          ),
        ),
        onPressed: () {
          Routes.push(context, Routes.addEditAddress, extra: {
            'edit': false,
          });
        },
        label: const Text(
          'Add new Address',
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
            separatorBuilder: (_, i) =>
                const AppDivider(height: 1).paddingV(24.h),
            itemCount: (state.user.address ?? []).length,
          );
        }

        return const SizedBox.shrink();
      },
    );
  }
}
