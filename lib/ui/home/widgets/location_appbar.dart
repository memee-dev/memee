import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:memee/blocs/index/index_cubit.dart';
import 'package:memee/blocs/user/user_cubit.dart';
import 'package:memee/core/initializer/app_di.dart';
import 'package:memee/ui/__shared/extensions/widget_extensions.dart';
import 'package:memee/ui/__shared/widgets/default_address_shimmer.dart';

class LocationAppbar extends StatelessWidget implements PreferredSizeWidget {
  final IndexCubit indexCubit;
  final GestureTapCallback? onTap;

  LocationAppbar({Key? key, required this.indexCubit, this.onTap})
      : super(key: key);

  final userCubit = locator.get<UserCubit>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: BlocBuilder<IndexCubit, int>(
        bloc: indexCubit,
        builder: (context, state) {
          return state == 3
              ? const Align(
                  alignment: Alignment.centerLeft,
                  child: BackButton(),
                )
              : BlocBuilder<UserCubit, UserState>(
                  bloc: userCubit..getDefaultAddress(),
                  builder: (context, user) {
                    if (user is UserLoading) {
                      return const DefaultAddressShimmer();
                    } else if (user is UserDefaultAddressState) {
                      final address = user.address;
                      return InkWell(
                        onTap: onTap,
                        child: ListTile(
                          title: Row(
                            children: [
                              Icon(
                                Icons.home_filled,
                                color: Theme.of(context).colorScheme.primary,
                              ).gapRight(4.w),
                              Text(
                                'Home',
                                style: Theme.of(context).textTheme.bodyLarge,
                              ).gapRight(4.w),
                              Icon(
                                Icons.keyboard_arrow_down_outlined,
                                color: Theme.of(context).colorScheme.primary,
                              ),
                            ],
                          ),
                          subtitle: Text(
                            '${address.no},${address.street},${address.area},${address.city},${address.pincode},${address.landmark}',
                            maxLines: 2,
                            style: Theme.of(context).textTheme.bodySmall,
                          ).paddingV(
                            v: 4.h,
                          ),
                        ),
                      );
                    }
                    return const SizedBox.shrink();
                  },
                );
        },
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(
        56.h,
      );
}
