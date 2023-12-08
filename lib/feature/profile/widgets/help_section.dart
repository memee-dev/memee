import 'package:flutter/material.dart';
import 'package:memee/core/utils/app_strings.dart';
import 'package:memee/feature/profile/widgets/profile_item.dart';

class HelpSection extends StatelessWidget {
  const HelpSection({super.key});

  @override
  Widget build(BuildContext context) {
    return const ProfileItem(
      title: AppStrings.help,
      subtitle: AppStrings.raiseQueries,
      icon: Icons.help,
    );
  }
}
