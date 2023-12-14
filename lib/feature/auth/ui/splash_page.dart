import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:memee/blocs/hide/bool_cubit.dart';
import 'package:memee/core/utils/app_assets.dart';
import 'package:memee/core/utils/app_di.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            BlocBuilder<HideCubit, bool>(
              bloc: locator.get<HideCubit>()..show(true, seconds: 1),
              builder: (context, state) {
                return AnimatedOpacity(
                  opacity: state ? 1 : 0,
                  duration: const Duration(microseconds: 500),
                  child: Image.asset(
                    AppAssets.logo,
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
