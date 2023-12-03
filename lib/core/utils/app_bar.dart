import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:memee/core/utils/app_colors.dart';
import 'package:memee/core/utils/app_divider.dart';

class AppbarTemplate extends StatelessWidget implements PreferredSizeWidget {
  final String title;

  const AppbarTemplate({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(
        title,
        style: Theme.of(context).textTheme.titleLarge,
      ),
      elevation: 0,
      backgroundColor: AppColors.bgColor,
      leading: const AppBackButton(),
    );
  }

  @override
  Size get preferredSize => Size(0, 56.h);
}
