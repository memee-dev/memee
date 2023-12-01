import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:memee/core/extensions/widget_extensions.dart';
import 'package:memee/feature/auth/bloc/auth_cubit.dart';
import 'package:memee/blocs/user/user_cubit.dart';
import 'package:memee/core/widgets/app_button.dart';
import 'package:memee/feature/profile/help_section.dart';
import 'package:memee/feature/profile/profile_saved_address.dart';
import 'package:memee/feature/profile/settings_section.dart';
import 'package:memee/feature/profile/user_info/user_information.dart';

import '../../core/utils/app_di.dart';
import '../../core/utils/app_strings.dart';

class ProfileWidget extends StatelessWidget {
  const ProfileWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<UserCubit>.value(
      value: locator.get<UserCubit>(),
      child: _Profile(),
    );
  }
}

class _Profile extends StatelessWidget {
  final _cubit = locator.get<UserCubit>();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const UserInformationWidget(),
        SizedBox(height: 24.h),
        if (_cubit.currentUser.address!.isNotEmpty)
          SavedAddressesSection(
            address: _cubit.currentUser.address!.first,
          ).gapBottom(24.h),

        // const SettingsSection(),
        // SizedBox(height: 24.h),
        // const HelpSection(),
        const Spacer(),
        AppButton.primary(
          text: AppStrings.logout,
          onPressed: () => locator.get<AuthCubit>().reset(),
        ),
      ],
    ).paddingS();
  }
}
