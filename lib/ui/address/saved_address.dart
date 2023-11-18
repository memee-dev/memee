import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:memee/blocs/user/user_cubit.dart';
import 'package:memee/core/initializer/app_di.dart';
import 'package:memee/core/shared/app_divider.dart';
import 'package:memee/ui/__shared/extensions/widget_extensions.dart';
import 'package:memee/ui/__shared/widgets/default_address_shimmer.dart';
import 'package:memee/ui/address/widgets/saved_address_item.dart';

class SavedAddress extends StatelessWidget {
  SavedAddress({super.key});

  final userCubit = locator.get<UserCubit>();

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
      body: BlocBuilder<UserCubit, UserState>(
        bloc: userCubit..getSavedAddress(),
        builder: (context, state) {
          if (state is UserLoading) {
            return const DefaultAddressShimmer();
          } else if (state is SavedAddressState) {
            return ListView.separated(
              padding: EdgeInsets.symmetric(
                horizontal: 16.h,
                vertical: 16.w,
              ),
              itemBuilder: (_, i) {
                return SavedAddressItem(
                  address: state.address[i],
                  onEdit: () {},
                );
              },
              separatorBuilder: (_, i) => const AppDivider(height: 1).paddingV(
                v: 24.h,
              ),
              itemCount: state is UserLoading ? 4 : state.address.length,
            );
          }

          return const SizedBox.shrink();
        },
      ),
    );
  }
}
