import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:memee/blocs/user/user_cubit.dart';
import 'package:memee/core/shared/app_strings.dart';

import '../blocs/auth/auth_cubit.dart';
import '../blocs/login/login_cubit.dart';
import '../blocs/theme/theme_cubit.dart';
import '../core/initializer/app_di.dart';
import '../core/initializer/app_router.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(360, 690),
      minTextAdapt: true,
      splitScreenMode: true,
      child: MultiBlocProvider(
        providers: [
          BlocProvider<ThemeCubit>(
            create: (_) => locator.get<ThemeCubit>(),
          ),
          BlocProvider<AuthCubit>(
            create: (_) =>
                locator.get<AuthCubit>()..checkAuthenticationStatus(),
          ),
          BlocProvider<LoginCubit>(
            create: (_) => locator.get<LoginCubit>(),
          ),
          BlocProvider<UserCubit>(
            create: (_) => locator.get<UserCubit>()..getCurrentUserInfo(),
          ),
        ],
        child: BlocBuilder<ThemeCubit, ThemeData>(
          builder: (_, themeState) {
            return MaterialApp.router(
              debugShowCheckedModeBanner: false,
              title: AppStrings.appName,
              theme: themeState,
              routerConfig: appRouter,
            );
          },
        ),
      ),
    );
  }
}
