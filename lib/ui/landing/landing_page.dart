import 'package:flutter/material.dart';
import 'package:memee/core/initializer/app_di.dart';
import 'package:memee/ui/__shared/extensions/widget_extensions.dart';

import '../../blocs/login/login_cubit.dart';
import '../../core/shared/app_strings.dart';
import '../home/home_widget.dart';

class LandingPage extends StatelessWidget {
  const LandingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(AppStrings.appName),
        actions: [
          InkWell(
            onTap: () => locator.get<LoginCubit>().reset(),
            child: const Center(child: Text(AppStrings.logout)).paddingH(),
          ),
        ],
      ),
      body: const HomeWidget(),
    );
  }
}
