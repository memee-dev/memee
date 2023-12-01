import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:memee/blocs/user/user_cubit.dart';
import 'package:memee/core/utils/app_strings.dart';

import 'auth/bloc/auth_cubit.dart';
import 'auth/bloc/login_cubit.dart';
import '../core/blocs/theme_cubit.dart';
import '../core/utils/app_di.dart';
import '../core/utils/app_router.dart';

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
          BlocProvider<AuthCubit>.value(
            value: locator.get<AuthCubit>()..checkAuthenticationStatus(),
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
