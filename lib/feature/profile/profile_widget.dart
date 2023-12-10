import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:memee/blocs/user/user_cubit.dart';
import 'package:memee/core/extensions/widget_extensions.dart';
import 'package:memee/core/utils/app_router.dart';
import 'package:memee/core/widgets/app_button.dart';
import 'package:memee/feature/auth/bloc/auth_cubit.dart';
import 'package:memee/feature/profile/widgets/no_address_found.dart';
import 'package:memee/feature/profile/widgets/profile_item.dart';
import 'package:memee/feature/profile/widgets/user_information.dart';

import '../../core/utils/app_di.dart';
import '../../core/utils/app_strings.dart';

class ProfileWidget extends StatelessWidget {
  const ProfileWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<UserCubit>.value(
      value: locator.get<UserCubit>(),
      child: SingleChildScrollView(
        padding: EdgeInsets.all(
          16.w,
        ),
        child: _Profile(),
      ),
    );
  }
}

class _Profile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const UserInformationWidget(),
        SizedBox(height: 24.h),
        BlocBuilder<UserCubit, UserState>(
          bloc: locator.get<UserCubit>(),
          builder: (context, state) {
            if (state is CurrentUserState) {
              var address = state.user.defaultAddress;
              return ProfileItem(
                title: AppStrings.savedAddress,
                subtitle:
                    '${address?.no},${address?.street},${address?.area},${address?.city},${address?.pincode},${address?.landmark}',
                icon: Icons.bookmark_added_rounded,
                onPressed: () => Routes.push(context, Routes.savedAddress),
                trailingIcon: Icons.edit,
              ).gapBottom(24.h);
            }
            return const NoAddressFound().gapBottom(24.h);
          },
        ),
        const ProfileItem(
          title: AppStrings.settings,
          subtitle: AppStrings.smsNotifications,
          icon: Icons.settings,
        ).gapBottom(24.h),
        const ProfileItem(
          title: AppStrings.help,
          subtitle: AppStrings.raiseQueries,
          icon: Icons.help,
        ).gapBottom(24.h),
        ProfileItem(
          title: AppStrings.orders,
          subtitle: AppStrings.viewAllOrdersHere,
          icon: Icons.event_note_sharp,
          onPressed: () => Routes.push(context, Routes.orders),
        ).gapBottom(24.h),
        AppButton.primary(
          text: AppStrings.logout,
          onPressed: () {
            locator.get<AuthCubit>().reset();
          },
          height: 36.h,
        ),
      ],
    );
  }
}
