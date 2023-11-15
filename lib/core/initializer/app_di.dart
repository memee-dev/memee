import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_it/get_it.dart';
import 'package:memee/blocs/hide_and_seek/hide_and_seek_cubit.dart';
import 'package:memee/blocs/index/index_cubit.dart';
import 'package:memee/blocs/product_cubit/product_cubit.dart';

import '../../blocs/auth/auth_cubit.dart';
import '../../blocs/login/login_cubit.dart';
import '../../blocs/prayer_time/prayer_time_cubit.dart';
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
    () => AuthCubit(locator()),
  );
  locator.registerLazySingleton<LoginCubit>(
    () => LoginCubit(locator()),
  );
  locator.registerLazySingleton<PrayerTimeCubit>(
    () => PrayerTimeCubit(locator()),
  );
  locator.registerFactory<HideAndSeekCubit>(
    () => HideAndSeekCubit(),
  );
  locator.registerFactory<IndexCubit>(
    () => IndexCubit(),
  );
  locator.registerFactory<ProductCubit>(
    () => ProductCubit(locator()),
  );
}
