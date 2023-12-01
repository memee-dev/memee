import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:memee/feature/auth/ui/auth_page.dart';
import 'package:memee/models/product_model.dart';
import 'package:memee/feature/address/address_edit_screen.dart';
import 'package:memee/feature/address/saved_address_screen.dart';
import 'package:memee/feature/cart/cart_screen.dart';
import 'package:memee/feature/product/product_detail_screen.dart';
import 'package:memee/feature/profile/profile_widget.dart';
import 'package:memee/feature/profile/user_info/add_user_info_screen.dart';

final GoRouter appRouter = GoRouter(
  navigatorKey: GlobalKey<NavigatorState>(),
  initialLocation: Routes.root,
  routes: [
    GoRoute(
      path: Routes.root,
      builder: (_, state) => const AuthPage(),
    ),
    GoRoute(
      path: Routes.productDetails,
      builder: (_, state) {
        return ProductDescriptionScreen(
          product: state.extra as ProductModel,
        );
      },
    ),
    GoRoute(
      path: Routes.shoppingCart,
      builder: (_, state) => CartScreen(),
    ),
    GoRoute(
      path: Routes.profile,
      builder: (_, state) => const ProfileWidget(),
    ),
    GoRoute(
      path: Routes.savedAddress,
      builder: (_, state) => const SavedAddressScreen(),
    ),
    GoRoute(
      path: Routes.addEditAddress,
      builder: (_, state) => AddressEditScreen(
        map: state.extra as Map<String, dynamic>,
      ),
    ),
    GoRoute(
      path: Routes.addUserInfo,
      builder: (_, state) => AddUserInfoScreen(
        map: state.extra as Map<String, dynamic>,
      ),
    ),
  ],
);

mixin Routes {
  static const root = '/';
  static const shoppingCart = '/shoppingCart';
  static const productDetails = '/productDetails';
  static const allProducts = '/allProducts';
  static const profile = '/profile';
  static const savedAddress = '/savedAddress';
  static const addEditAddress = '/addEditAddress';
  static const addUserInfo = '/addUserInfo';

  static push(BuildContext context, String path, {Object? extra}) {
    context.push(path, extra: extra);
  }

  static void pop(BuildContext context, {Object? value}) {
    context.pop([value]);
  }
}
