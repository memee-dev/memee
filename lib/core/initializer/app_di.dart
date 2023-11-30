import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_it/get_it.dart';
import 'package:memee/blocs/cart/cart_cubit.dart';
import 'package:memee/blocs/categories/categories_cubit.dart';
import 'package:memee/blocs/form/form_validation_cubit.dart';
import 'package:memee/blocs/hide_and_seek/toggle_cubit.dart';
import 'package:memee/blocs/index/index_cubit.dart';
import 'package:memee/blocs/map_cubit/map_cubit.dart';
import 'package:memee/blocs/payment/payment_cubit.dart';
import 'package:memee/blocs/product_cubit/product_cubit.dart';
import 'package:memee/blocs/user/user_cubit.dart';

import '../../blocs/auth/auth_cubit.dart';
import '../../blocs/login/login_cubit.dart';
import '../../blocs/theme/theme_cubit.dart';

final locator = GetIt.I;

void init() {
  apiConfig(locator);
  blocConfig(locator);
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
    () => AuthCubit(locator(), locator()),
  );
  locator.registerLazySingleton<LoginCubit>(
    () => LoginCubit(locator(), locator()),
  );
  locator.registerLazySingleton<UserCubit>(
    () => UserCubit(locator(), locator()),
  );
  locator.registerFactory<ToggleCubit>(
    () => ToggleCubit(),
  );
  locator.registerFactory<IndexCubit>(
    () => IndexCubit(),
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
    () => CartCubit(locator(),locator()),
  );
  locator.registerLazySingleton<MapCubit>(
    () => MapCubit(),
  );
  locator.registerLazySingleton<PaymentCubit>(
    () => PaymentCubit(),
  );
}
