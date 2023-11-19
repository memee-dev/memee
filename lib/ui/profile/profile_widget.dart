import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:memee/blocs/login/login_cubit.dart';
import 'package:memee/ui/__shared/widgets/app_button.dart';
import 'package:memee/ui/profile/help_section.dart';
import 'package:memee/ui/profile/saved_address.dart';
import 'package:memee/ui/profile/settings_section.dart';
import 'package:memee/ui/profile/user_information.dart';

import '../../core/initializer/app_di.dart';
import '../../core/shared/app_strings.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.all(
        12.w,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const UserInformationWidget(),
          SizedBox(height: 24.h),
          const SavedAddressesSection(),
          SizedBox(height: 24.h),
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
      ),
    );
  }
}
