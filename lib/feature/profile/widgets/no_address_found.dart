import 'package:flutter/material.dart';
import 'package:memee/core/utils/app_router.dart';
import 'package:memee/core/utils/app_strings.dart';
import 'package:memee/feature/profile/widgets/profile_item.dart';

class NoAddressFound extends StatelessWidget {
  const NoAddressFound({super.key});

  @override
  Widget build(BuildContext context) {
    return ProfileItem(
      title: AppStrings.savedAddress,
      subtitle: 'No address found, set a default address too proceed',
      icon: Icons.bookmark_added_rounded,
      trailingIcon: Icons.add,
      onPressed: () => Routes.push(context, Routes.savedAddress),
    );
  }
}
