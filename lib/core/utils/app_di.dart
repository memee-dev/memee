import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_it/get_it.dart';
import 'package:memee/blocs/categories/categories_cubit.dart';
import 'package:memee/blocs/form/form_validation_cubit.dart';
import 'package:memee/blocs/hide/hide_cubit.dart';
import 'package:memee/blocs/index/index_cubit.dart';
import 'package:memee/blocs/map_cubit/map_cubit.dart';
import 'package:memee/feature/cart/bloc/payment/payment_cubit.dart';
import 'package:memee/blocs/user/user_cubit.dart';
import 'package:memee/core/blocs/refresh_cubit.dart';
import 'package:memee/feature/auth/bloc/register_cubit.dart';
import 'package:memee/feature/auth/repo/user_repo.dart';
import 'package:memee/feature/cart/bloc/cart_bloc/cart_cubit.dart';
import 'package:memee/feature/order/bloc/order_cubit.dart';
import 'package:memee/feature/product/bloc/product_cubit/product_cubit.dart';

import '../../feature/auth/bloc/auth_cubit.dart';
import '../../feature/auth/bloc/login_cubit.dart';
import '../blocs/theme_cubit.dart';

final locator = GetIt.I;

void init() {
  apiConfig(locator);
  blocConfig(locator);
  repoConfig(locator);
}

void apiConfig(GetIt locator) {
  locator.registerLazySingleton<FirebaseAuth>(
    () => FirebaseAuth.instance,
  );

  locator.registerLazySingleton<FirebaseFirestore>(
    () => FirebaseFirestore.instance,
  );
}

void blocConfig(GetIt locator) {
  locator.registerLazySingleton<ThemeCubit>(
    () => ThemeCubit(),
  );
  locator.registerLazySingleton<AuthCubit>(
    () => AuthCubit(),
  );
  locator.registerLazySingleton<RegisterCubit>(
    () => RegisterCubit(),
  );
  locator.registerLazySingleton<LoginCubit>(
    () => LoginCubit(),
  );
  locator.registerLazySingleton<UserCubit>(
    () => UserCubit(locator(), locator()),
  );
  locator.registerFactory<RefreshCubit>(RefreshCubit.new);
  locator.registerFactory<IndexCubit>(
    () => IndexCubit(),
  );
  locator.registerLazySingleton<HideCubit>(
    () => HideCubit(),
  );
  locator.registerFactory<FormValidationCubit>(
    () => FormValidationCubit(),
  );

  locator.registerFactory<ProductCubit>(
    () => ProductCubit(locator()),
  );
  locator.registerFactory<CategoriesCubit>(
    () => CategoriesCubit(locator()),
  );
  locator.registerLazySingleton<CartCubit>(
    () => CartCubit(locator(), locator()),
  );
  locator.registerLazySingleton<MapCubit>(
    () => MapCubit(),
  );
  locator.registerLazySingleton<PaymentCubit>(
    () => PaymentCubit(locator(), locator()),
  );
  locator.registerLazySingleton<OrderCubit>(
    () => OrderCubit(locator()),
  );
}

void repoConfig(GetIt locator) {
  locator.registerLazySingleton<UserRepo>(
    () => UserRepo(),
  );
}
