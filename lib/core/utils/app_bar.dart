import 'package:flutter/material.dart';
import 'package:memee/core/extensions/string_extension.dart';
import 'package:memee/core/utils/app_colors.dart';
import 'package:memee/core/widgets/app_divider.dart';

class ScaffoldTemplate extends StatelessWidget {
  final String title;
  final Widget body;
  final List<Widget>? actions;
  final Widget? floatingActionButton;

  const ScaffoldTemplate({
    super.key,
    required this.title,
    this.actions,
    required this.body,
    this.floatingActionButton,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: body,
      appBar: AppBar(
        title: Text(
          title.toCapitalize(),
          style: Theme.of(context).textTheme.titleLarge,
        ),
        elevation: 0,
        backgroundColor: AppColors.bgColor,
        leading: const AppBackButton(),
        actions: actions,
      ),
      floatingActionButton: floatingActionButton,
    );
  }
}
