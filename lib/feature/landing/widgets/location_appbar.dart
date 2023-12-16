import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:memee/blocs/index/index_cubit.dart';
import 'package:memee/blocs/user/user_cubit.dart';
import 'package:memee/core/extensions/string_extension.dart';
import 'package:memee/core/extensions/theme_extension.dart';
import 'package:memee/core/utils/app_colors.dart';
import 'package:memee/core/utils/app_di.dart';
import 'package:memee/core/utils/app_strings.dart';
import 'package:memee/core/extensions/widget_extensions.dart';
import 'package:memee/core/widgets/default_address_shimmer.dart';
import 'package:memee/core/widgets/lottie_location.dart';

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
    return BlocBuilder<IndexCubit, int>(
      bloc: indexCubit,
      builder: (_, state) {
        return state != 0
            ? Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  state == 1
                      ? AppStrings.favorite
                      : state == 2
                          ? AppStrings.cart
                          : AppStrings.profile,
                  style: Theme.of(context).textTheme.displayXSMedium,
                ),
              ).paddingS(v: 16.h)
            : BlocBuilder<UserCubit, UserState>(
                bloc: userCubit,
                builder: (context, user) {
                  if (user == UserState.loading) {
                    return const DefaultAddressShimmer();
                  } else if (user == UserState.success) {
                    final address = userCubit.currentUser?.defaultAddress;
                    return address != null
                        ? InkWell(
                            onTap: onTap,
                            child: Container(
                              padding: EdgeInsets.symmetric(
                                horizontal: 8.w,
                                vertical: 12.h,
                              ),
                              child: Row(
                                children: [
                                  LottieLocation(height: 26.h),
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.baseline,
                                    textBaseline: TextBaseline.alphabetic,
                                    children: [
                                      Text(
                                        'Home',
                                        style: Theme.of(context)
                                            .textTheme
                                            .textSMSemibold
                                            .copyWith(
                                              color: AppColors.textLightColor,
                                            ),
                                      ).gapBottom(1.w),
                                      Text(
                                        '${address.no.toCapitalize()},\t${address.area}',
                                        maxLines: 2,
                                        style: Theme.of(context)
                                            .textTheme
                                            .textSMMedium
                                            .copyWith(
                                              color: AppColors.textLightColor,
                                            ),
                                      )
                                    ],
                                  ),
                                  Icon(
                                    Icons.keyboard_arrow_down_outlined,
                                    color: AppColors.textAccentDarkColor,
                                    size: 24.r,
                                  ),
                                ],
                              ),
                            ),
                          )
                        : const SizedBox.shrink().gapTop(48.h);
                  }
                  return const SizedBox.shrink();
                },
              );
      },
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(
        kToolbarHeight.h,
      );
}
