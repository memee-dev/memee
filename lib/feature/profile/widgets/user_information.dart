import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:memee/blocs/user/user_cubit.dart';
import 'package:memee/core/extensions/string_extension.dart';
import 'package:memee/core/extensions/theme_extension.dart';
import 'package:memee/core/utils/app_colors.dart';
import 'package:memee/core/utils/app_di.dart';
import 'package:memee/core/utils/app_router.dart';
import 'package:memee/core/widgets/app_divider.dart';
import 'package:memee/core/extensions/widget_extensions.dart';
import 'package:memee/core/widgets/default_address_shimmer.dart';

class UserInformationWidget extends StatelessWidget {
  const UserInformationWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final _userCubit = locator.get<UserCubit>();
    return BlocConsumer<UserCubit, UserState>(
      listener: (context, state) {
        if (state == UserState.userDataUpdate) {
          _userCubit.getCurrentUserInfo();
        }
      },
      bloc: _userCubit,
      builder: (context, state) {
        if (state == UserState.infoLoading) {
          return const DefaultAddressShimmer();
        }
        return ListTile(
          contentPadding: EdgeInsets.zero,
          title: Text(
            _userCubit.currentUser?.userName.toCapitalize() ?? '',
            style: Theme.of(context).textTheme.textLGMedium,
          ),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 8.h),
              Row(
                children: [
                  Icon(
                    Icons.email_outlined,
                    size: 16.sp,
                    color: AppColors.textAccentDarkColor,
                  ).gapRight(
                    4.w,
                  ),
                  Expanded(
                    child: Text(
                      _userCubit.currentUser?.email ?? '',
                      maxLines: 2,
                      style: Theme.of(context).textTheme.textSMMedium.copyWith(
                            color: AppColors.textLightColor,
                          ),
                    ).paddingV(4.h),
                  ),
                ],
              ),
              Row(
                children: [
                  Icon(
                    Icons.phone,
                    size: 16.sp,
                    color: AppColors.textAccentDarkColor,
                  ).gapRight(
                    4.w,
                  ),
                  Expanded(
                    child: Text(
                      _userCubit.currentUser?.phoneNumber ?? '',
                      style: Theme.of(context).textTheme.textSMMedium.copyWith(
                            color: AppColors.textLightColor,
                          ),
                    ),
                  ),
                ],
              ).gapBottom(
                12.h,
              ),
              const AppDivider(),
            ],
          ),
          trailing: IconButton(
            onPressed: () async {
              Routes.push(
                context,
                Routes.addUserInfo,
                extra: {
                  'userName': _userCubit.currentUser?.userName,
                  'userEmail': _userCubit.currentUser?.email,
                  'phoneNo': _userCubit.currentUser?.phoneNumber,
                },
              );
            },
            icon: Icon(
              Icons.edit,
              color: AppColors.textAccentDarkColor,
              size: 24.r,
            ),
          ),
        );
      },
    );
  }
}
