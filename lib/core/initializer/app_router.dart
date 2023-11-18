import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:memee/models/product_entity.dart';
import 'package:memee/models/product_model.dart';
import 'package:memee/ui/address/saved_address.dart';
import 'package:memee/ui/cart/cart_screen.dart';
import 'package:memee/ui/product/product_detail_screen.dart';
import 'package:memee/ui/profile/profile_widget.dart';

import '../../ui/landing/landing_page.dart';
import '../../ui/login/login_page.dart';
import '../../ui/splash/splash_page.dart';

final GoRouter appRouter = GoRouter(
  navigatorKey: GlobalKey<NavigatorState>(),
  initialLocation: Routes.root,
  routes: [
    GoRoute(
      path: Routes.root,
      builder: (_, state) => const SplashPage(),
      routes: [
        GoRoute(
          path: Routes.login,
          builder: (_, state) => LoginPage(),
        ),
        GoRoute(
          path: Routes.landing,
          builder: (_, state) => LandingPage(),
        ),
        GoRoute(
          path: Routes.productDetails,
          builder: (_, state) {
            return ProductDescriptionScreen(
              product: state.extra as ProductEntity,
            );
          },
        ),
        GoRoute(
          path: Routes.shoppingCart,
          builder: (_, state) => ShoppingCartScreen(
            state.extra as List<Product>,
          ),
        ),
        GoRoute(
          path: Routes.profile,
          builder: (_, state) => const ProfileScreen(),
        ),
        GoRoute(
          path: Routes.savedAddress,
          builder: (_, state) => SavedAddress(),
        ),
      ],
    ),
  ],
);

mixin Routes {
  static const shoppingCart = 'shoppingCart';
  static const productDetails = 'productDetails';
  static const landing = 'landing';
  static const login = 'login';
  static const root = '/';
  static const allProducts = 'allProducts';
  static const profile = 'profile';
  static const savedAddress = 'savedAddress';

  static void appGoRouter(BuildContext context, String path, {Object? extra}) {
    context.push('${Routes.root}$path', extra: extra);
  }
}
