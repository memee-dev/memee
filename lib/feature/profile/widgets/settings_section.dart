import 'package:flutter/material.dart';
import 'package:memee/core/utils/app_strings.dart';
import 'package:memee/feature/profile/widgets/profile_item.dart';

class SettingsSection extends StatelessWidget {
  const SettingsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return ProfileItem(
      title: AppStrings.settings,
      subtitle: AppStrings.smsNotifications,
      icon: Icons.settings,
    );
  }
}
