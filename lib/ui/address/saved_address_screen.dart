import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:memee/blocs/user/user_cubit.dart';
import 'package:memee/core/initializer/app_di.dart';
import 'package:memee/core/initializer/app_router.dart';
import 'package:memee/core/shared/app_divider.dart';
import 'package:memee/core/shared/app_strings.dart';
import 'package:memee/ui/__shared/extensions/widget_extensions.dart';
import 'package:memee/ui/__shared/widgets/confirmation_dialog.dart';
import 'package:memee/ui/__shared/widgets/default_address_shimmer.dart';
import 'package:memee/ui/address/widgets/saved_address_item.dart';

class SavedAddressScreen extends StatelessWidget {
  const SavedAddressScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Saved Address',
          style: Theme.of(context).textTheme.titleLarge,
        ),
        leading: const BackButton(),
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
          Routes.push(context, Routes.addAddress, extra: false);
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
        } else if (state is SavedAddressState) {
          return ListView.separated(
            padding: EdgeInsets.symmetric(
              horizontal: 16.h,
              vertical: 16.w,
            ),
            itemBuilder: (_, i) {
              return SavedAddressItem(
                address: state.address[i],
                onEdit: () {
                  Routes.push(context, Routes.editAddress,
                      extra: state.address[i]);
                },
              );
            },
            separatorBuilder: (_, i) => const AppDivider(height: 1).paddingV(
              v: 24.h,
            ),
            itemCount: state.address.length,
          );
        }

        return const SizedBox.shrink();
      },
    );
  }
}
