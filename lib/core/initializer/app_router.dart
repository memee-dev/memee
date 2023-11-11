import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:memee/models/product_model.dart';
import 'package:memee/ui/product_detail/product_detail_screen.dart';

import '../../ui/landing/landing_page.dart';
import '../../ui/login/login_page.dart';
import '../../ui/splash/splash_page.dart';

final GoRouter appRouter = GoRouter(
  navigatorKey: GlobalKey<NavigatorState>(),
  initialLocation: '/',
  routes: [
    GoRoute(
      path: '/',
      builder: (_, state) => const SplashPage(),
      routes: [
        GoRoute(
          path: 'login',
          builder: (_, state) => LoginPage(),
        ),
        GoRoute(
          path: 'landing',
          builder: (_, state) => LandingPage(),
        ),
        GoRoute(
          path: 'productDetails',
          builder: (_, state) {
            return ProductDescriptionScreen(
              product: state.extra as Product,
            );
          },
        ),
        GoRoute(
          path: 'cart',
          builder: (_, state) => const ShoppingCartScreen([]),
        ),
      ],
    ),
  ],
);
