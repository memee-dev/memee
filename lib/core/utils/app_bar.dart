import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:memee/core/extensions/string_extension.dart';
import 'package:memee/core/utils/app_colors.dart';
import 'package:memee/core/widgets/app_divider.dart';

class AppbarTemplate extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final List<Widget>? actions;

  const AppbarTemplate({super.key, required this.title, this.actions});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(
        title.toCapitalize(),
        style: Theme.of(context).textTheme.titleLarge,
      ),
      elevation: 0,
      backgroundColor: AppColors.bgColor,
      leading: const AppBackButton(),
      actions: actions,
    );
  }

  @override
  Size get preferredSize => Size(0, 56.h);
}
