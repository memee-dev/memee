import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:memee/blocs/login/login_cubit.dart';
import 'package:memee/blocs/user/user_cubit.dart';
import 'package:memee/ui/__shared/widgets/app_button.dart';
import 'package:memee/ui/profile/help_section.dart';
import 'package:memee/ui/profile/profile_saved_address.dart';
import 'package:memee/ui/profile/settings_section.dart';
import 'package:memee/ui/profile/user_info/user_information.dart';

import '../../core/initializer/app_di.dart';
import '../../core/shared/app_strings.dart';

class ProfileWidget extends StatelessWidget {
  const ProfileWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<UserCubit>.value(
      value: locator.get<UserCubit>(),
      child: SingleChildScrollView(
        padding: EdgeInsets.all(
          12.w,
        ),
        child: _Profile(),
      ),
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
        if (_cubit.currentUser.address.isNotEmpty) ...[
          SavedAddressesSection(
            address: _cubit.currentUser.defaultAddress!,
          ),
          SizedBox(height: 24.h),
        ],
        const SettingsSection(),
        SizedBox(height: 24.h),
        const HelpSection(),
        SizedBox(height: 24.h),
        AppButton(
          label: AppStrings.logout,
          onTap: () {
            locator.get<LoginCubit>().reset();
          },
        ),
      ],
    );
  }
}
