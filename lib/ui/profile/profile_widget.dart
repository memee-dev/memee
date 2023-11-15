import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:memee/ui/profile/help_section.dart';
import 'package:memee/ui/profile/saved_address.dart';
import 'package:memee/ui/profile/settings_section.dart';
import 'package:memee/ui/profile/user_information.dart';

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
        ],
      ),
    );
  }
}
