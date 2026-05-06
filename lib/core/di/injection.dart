

import 'package:connectivity_plus/connectivity_plus.dart' show Connectivity;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:newsflow/core/network/api_client.dart';
import 'package:newsflow/core/network/network_info.dart';
import 'package:newsflow/core/storage/secure_storage.dart';

/// Global dependency injection container
final getIt = GetIt.instance;


/// Set up all dependencies
Future<void> setupDependencies() async {
  // Initialize all dependencies here
   await _registerCore();
}

/// Register core dependencies
Future<void> _registerCore() async {
  // ─── Secure Storage ───────────────────────────────
  const androidOptions = AndroidOptions(encryptedSharedPreferences: true);

   getIt.registerLazySingleton<SecureStorage>(() => SecureStorage(FlutterSecureStorage(aOptions: androidOptions)));   

//network
  getIt.registerLazySingleton<Connectivity>(
    () => Connectivity(),
  );

  getIt.registerLazySingleton<NetworkInfo>(
    () => NetworkInfoImpl(getIt<Connectivity>()),
  );

  getIt.registerLazySingleton<ApiClient>(() => ApiClient(secureStorage: getIt<SecureStorage>()));
}


