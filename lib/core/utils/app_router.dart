import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:memee/core/utils/app_bar.dart';
import 'package:memee/core/utils/app_strings.dart';
import 'package:memee/core/widgets/order_confirmation.dart';
import 'package:memee/feature/address/address_edit_screen.dart';
import 'package:memee/feature/address/saved_address_screen.dart';
import 'package:memee/feature/auth/ui/auth_page.dart';
import 'package:memee/feature/auth/ui/login_page.dart';
import 'package:memee/feature/auth/ui/user_info/add_user_info_screen.dart';
import 'package:memee/feature/cart//ui/cart_screen.dart';
import 'package:memee/feature/landing/landing_page.dart';
import 'package:memee/feature/order/ui/order_details_screen.dart';
import 'package:memee/feature/order/ui/order_list_screen.dart';
import 'package:memee/feature/product/all_products.dart';
import 'package:memee/feature/product/product_detail_screen.dart';
import 'package:memee/feature/profile/profile_widget.dart';
import 'package:memee/feature/search/search_screen.dart';
import 'package:memee/feature/settings/ui/settings_screen.dart';
import 'package:memee/models/order_model.dart';
import 'package:memee/models/product_model.dart';

final GoRouter appRouter = GoRouter(
  navigatorKey: GlobalKey<NavigatorState>(),
  initialLocation: Routes.root,
  routes: [
    GoRoute(
      path: Routes.root,
      builder: (_, state) => const AuthPage(),
      routes: [
        GoRoute(
          path: Routes.login,
          builder: (_, state) => const LoginPage(),
        ),
        GoRoute(
          path: Routes.landing,
          builder: (_, state) => LandingPage(),
        ),
        GoRoute(
          path: Routes.productDetails,
          builder: (_, state) {
            return ProductDetailScreen(
              product: state.extra as ProductModel,
            );
          },
        ),
        GoRoute(
          path: Routes.shoppingCart,
          builder: (_, state) => const CartWidget(),
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
        GoRoute(
          path: Routes.addUserInfo,
          builder: (_, state) => AddUserInfoScreen(
            map: state.extra as Map<String, dynamic>,
          ),
        ),
        GoRoute(
          path: Routes.orderConfirmation,
          builder: (_, state) => OrderConfirmation(
            success: state.extra as bool,
          ),
        ),
        GoRoute(
          path: Routes.cart,
          builder: (_, state) => const ScaffoldTemplate(
            title: AppStrings.cart,
            body: CartWidget(),
          ),
        ),
        GoRoute(
          path: Routes.allProducts,
          builder: (_, state) => AllProductsScreen(
            map: state.extra as Map<String, dynamic>,
          ),
        ),
        GoRoute(
          path: Routes.orders,
          builder: (_, state) => const OrderListScreen(),
        ),
        GoRoute(
          path: Routes.orderDetails,
          builder: (_, state) =>
              OrderDetailsScreen(order: state.extra as OrderModel),
        ),
        GoRoute(
          path: Routes.settings,
          builder: (_, state) => const SettingsScreen(),
        ),
        GoRoute(
          path: Routes.search,
          builder: (_, state) => const SearchScreen(),
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
  static const addEditAddress = 'addEditAddress';
  static const addUserInfo = 'addUserInfo';
  static const orderConfirmation = 'orderConfirmation';
  static const cart = 'cart';
  static const orders = 'orders';
  static const orderDetails = 'orderDetails';
  static const settings = 'settings';
  static const search = 'search';

  static push(BuildContext context, String path, {Object? extra}) {
    context.push('${Routes.root}$path', extra: extra);
  }

  static pushReplacement(BuildContext context, String path, {Object? extra}) {
    context.go('${Routes.root}$path', extra: extra);
  }

  static void pop(BuildContext context, {Object? value}) {
    context.pop([value]);
  }
}
