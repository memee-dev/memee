import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:memee/blocs/form_cubit/form_validation_cubit.dart';
import 'package:memee/blocs/index/index_cubit.dart';
import 'package:memee/blocs/map_cubit/map_cubit.dart';
import 'package:memee/blocs/product_cubit/product_cubit.dart';
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
          BlocProvider<IndexCubit>(
            create: (_) => locator.get<IndexCubit>(),
          ),
          BlocProvider<ProductCubit>(
            create: (_) => locator.get<ProductCubit>(),
          ),
          BlocProvider<UserCubit>(
            create: (_) => locator.get<UserCubit>(),
          ),
          BlocProvider<FormValidationCubit>(
            create: (_) => locator.get<FormValidationCubit>(),
          ),
          BlocProvider<MapCubit>(
            create: (_) => locator.get<MapCubit>(),
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
