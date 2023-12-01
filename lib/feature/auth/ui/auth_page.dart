import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/auth_cubit.dart';
import '../../../core/utils/app_di.dart';
import 'landing/landing_page.dart';
import 'login/login_page.dart';
import 'splash/splash_page.dart';
import 'register/register_page.dart';

class AuthPage extends StatelessWidget {
  const AuthPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthCubit, AuthState>(
      bloc: locator.get<AuthCubit>(),
      builder: (_, state) {
        if (state == AuthState.unauthenticated) {
          return const LoginPage();
        } else if (state == AuthState.register) {
          return const RegisterPage();
        } else if (state == AuthState.authenticated) {
          return LandingPage();
        }
        return const SplashPage();
      },
    );
  }
}
