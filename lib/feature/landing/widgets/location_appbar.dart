import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:memee/blocs/index/index_cubit.dart';
import 'package:memee/blocs/user/user_cubit.dart';
import 'package:memee/core/extensions/theme_extension.dart';
import 'package:memee/core/utils/app_colors.dart';
import 'package:memee/core/utils/app_di.dart';
import 'package:memee/core/utils/app_strings.dart';
import 'package:memee/core/extensions/widget_extensions.dart';
import 'package:memee/core/widgets/default_address_shimmer.dart';

class LocationAppBar extends StatelessWidget implements PreferredSizeWidget {
  final IndexCubit indexCubit;
  final GestureTapCallback? onTap;

  const LocationAppBar({
    Key? key,
    required this.indexCubit,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final userCubit = locator.get<UserCubit>();
    return SafeArea(
      child: BlocBuilder<IndexCubit, int>(
        bloc: indexCubit,
        builder: (context, state) {
          return state != 0
              ? Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    state == 1
                        ? AppStrings.favorite
                        : state == 2
                            ? AppStrings.cart
                            : AppStrings.profile,
                    style: Theme.of(context).textTheme.displayMDBold,
                  ),
                ).paddingH()
              : BlocBuilder<UserCubit, UserState>(
                  bloc: userCubit..getCurrentUserInfo(),
                  builder: (context, user) {
                    if (user is UserInfoLoading) {
                      return const DefaultAddressShimmer();
                    } else if (user is CurrentUserState) {
                      final address = user.user.defaultAddress;
                      return address != null
                          ? InkWell(
                              onTap: onTap,
                              child: Container(
                                padding: EdgeInsets.symmetric(
                                  horizontal: 16.w,
                                  vertical: 12.h,
                                ),
                                child: ListTile(
                                  contentPadding: EdgeInsets.zero,
                                  title: Row(
                                    children: [
                                      const Icon(
                                        Icons.home_filled,
                                        color: AppColors.accentPinkColor,
                                      ).gapRight(4.w),
                                      Text(
                                        'Home',
                                        style: Theme.of(context)
                                            .textTheme
                                            .textSMBold
                                            .copyWith(
                                              color: AppColors.textLightColor,
                                            ),
                                      ).gapRight(4.w),
                                      const Icon(
                                        Icons.keyboard_arrow_down_outlined,
                                        color: AppColors.accentPinkColor,
                                      ),
                                    ],
                                  ),
                                  subtitle: Text(
                                    '${address.no},${address.street},${address.area},${address.city},${address.pincode},${address.landmark}',
                                    maxLines: 2,
                                    style: Theme.of(context)
                                        .textTheme
                                        .textSMBold
                                        .copyWith(
                                          color: AppColors.textLightColor,
                                        ),
                                  ).paddingV(4.h),
                                ),
                              ),
                            )
                          : const SizedBox.shrink();
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
