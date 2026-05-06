

import 'package:connectivity_plus/connectivity_plus.dart' show Connectivity;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:newsflow/core/network/api_client.dart';
import 'package:newsflow/core/network/network_info.dart';
import 'package:newsflow/core/storage/hive_boxes.dart';
import 'package:newsflow/core/storage/local_storage.dart';
import 'package:newsflow/core/storage/secure_storage.dart';

/// Global dependency injection container
final getIt = GetIt.instance;


/// Set up all dependencies
Future<void> setupDependencies() async {
  // Initialize all dependencies here
    await _initHive();
   await _registerCore();
}
//
Future<void> _initHive() async {
  // Initialize Hive with Flutter path
  await Hive.initFlutter();

  // Register TypeAdapters here later
  // Hive.registerAdapter(ArticleModelAdapter());

  // Open all boxes at startup
  await Hive.openBox(HiveBoxes.articles);
  await Hive.openBox(HiveBoxes.savedArticles);
  await Hive.openBox(HiveBoxes.user);
;
}


/// Register core dependencies
Future<void> _registerCore() async {
  // ─── Secure Storage ───────────────────────────────
  const androidOptions = AndroidOptions(encryptedSharedPreferences: true);

   getIt.registerLazySingleton<SecureStorage>(() => SecureStorage(FlutterSecureStorage(aOptions: androidOptions)));   

   getIt.registerLazySingleton<LocalStorage>(() => LocalStorage());

//network
  getIt.registerLazySingleton<Connectivity>(
    () => Connectivity(),
  );

  getIt.registerLazySingleton<NetworkInfo>(
    () => NetworkInfoImpl(getIt<Connectivity>()),
  );

  getIt.registerLazySingleton<ApiClient>(() => ApiClient(secureStorage: getIt<SecureStorage>()));
}


