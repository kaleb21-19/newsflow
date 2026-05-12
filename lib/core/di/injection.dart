

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
import 'package:newsflow/core/utils/app_config.dart';
import 'package:newsflow/features/auth/data/datasources/auth_remote_datasources.dart';
import 'package:newsflow/features/auth/data/datasources/mock_auth_datasource.dart';
import 'package:newsflow/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:newsflow/features/auth/domain/repositories/auth_repository.dart';
import 'package:newsflow/features/auth/domain/usecases/get_current_user_usecase.dart';
import 'package:newsflow/features/auth/domain/usecases/login_usecase.dart';
import 'package:newsflow/features/auth/domain/usecases/logout_usecase.dart';
import 'package:newsflow/features/auth/domain/usecases/register_usecase.dart';
import 'package:newsflow/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:newsflow/features/news/data/datasources/mock_news_datasource.dart';
import 'package:newsflow/features/news/data/datasources/news_remote_datasource.dart';
import 'package:newsflow/features/news/data/repositories/news_repository_impl.dart';
import 'package:newsflow/features/news/domain/repositories/news_repository.dart';
import 'package:newsflow/features/news/domain/usecases/get_catched_articles_usecase.dart';
import 'package:newsflow/features/news/domain/usecases/get_top_headlines_usecase.dart';
import 'package:newsflow/features/news/presentation/bloc/news_bloc.dart';
import 'package:newsflow/features/saved/data/repositories/%20saved_repository_impl.dart';
import 'package:newsflow/features/saved/domain/repositories/saved_repository.dart';
import 'package:newsflow/features/saved/domain/usecases/get_saved_articles_usecase.dart';
import 'package:newsflow/features/saved/domain/usecases/remove_article_usecase.dart';
import 'package:newsflow/features/saved/domain/usecases/save_article_usecase.dart';
import 'package:newsflow/features/saved/presentation/bloc/saved_bloc.dart';

/// Global dependency injection container
final getIt = GetIt.instance;


/// Set up all dependencies
Future<void> setupDependencies() async {
  // Initialize all dependencies here
    await _initHive();
   await _registerCore();
     _registerAuth();
     _registerNews();
     _registerSaved();
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
void _registerAuth() {
  // ─── Datasource ───────────────────────────────────
  // Use mock in development, real in production
  getIt.registerLazySingleton<AuthRemoteDatasource>(
    () => AppConfig.isDevelopment
        ? MockAuthDatasource()
        : AuthRemoteDatasourceImpl(
            apiClient: getIt<ApiClient>(),
          ),
  );

  // ─── Repository ───────────────────────────────────
  getIt.registerLazySingleton<AuthRepository>(
    () => AuthRepositoryImpl(
      remoteDatasource: getIt<AuthRemoteDatasource>(),
      secureStorage: getIt<SecureStorage>(),
      localStorage: getIt<LocalStorage>(),
      networkInfo: getIt<NetworkInfo>(),
    ),
  );

  // ─── Use Cases ────────────────────────────────────
  getIt.registerLazySingleton<LoginUsecase>(
    () => LoginUsecase(getIt<AuthRepository>()),
  );

  getIt.registerLazySingleton<RegisterUseCase>(
    () => RegisterUseCase(getIt<AuthRepository>()),
  );

  getIt.registerLazySingleton<LogoutUseCase>(
    () => LogoutUseCase(getIt<AuthRepository>()),
  );

  getIt.registerLazySingleton<GetCurrentUserUseCase>(
    () => GetCurrentUserUseCase(getIt<AuthRepository>()),
  );

  getIt.registerFactory<AuthBloc>(
    () => AuthBloc(
      loginUseCase: getIt<LoginUsecase>(),
      registerUseCase: getIt<RegisterUseCase>(),
      logoutUseCase: getIt<LogoutUseCase>(),
      getCurrentUserUseCase: getIt<GetCurrentUserUseCase>(),
    ),
  );
}
void _registerNews() {
  // ─── Datasource ───────────────────────────────────
  getIt.registerLazySingleton<NewsRemoteDataSource>(
    () => AppConfig.isDevelopment
        ? MockNewsDatasourceImpl()
        : NewsRemoteDataSourceImpl(
            apiClient: getIt<ApiClient>(),
          ),
  );

  // ─── Repository ───────────────────────────────────
  getIt.registerLazySingleton<NewsRepository>(
    () => NewsRepositoryImpl(
      remoteDatasource: getIt<NewsRemoteDataSource>(),
      localStorage: getIt<LocalStorage>(),
      networkInfo: getIt<NetworkInfo>(),
    ),
  );

  // ─── Use Cases ────────────────────────────────────
  getIt.registerLazySingleton<GetTopHeadlinesUseCase>(
    () => GetTopHeadlinesUseCase(getIt<NewsRepository>()),
  );

  getIt.registerLazySingleton<GetCachedArticlesUseCase>(
    () => GetCachedArticlesUseCase(getIt<NewsRepository>()),
  );

  // ─── BLoC ─────────────────────────────────────────
  getIt.registerFactory<NewsBloc>(
    () => NewsBloc(
      getTopHeadlinesUseCase: getIt<GetTopHeadlinesUseCase>(),
      getCachedArticlesUseCase: getIt<GetCachedArticlesUseCase>(),
    ),
  );
}

void _registerSaved(){
     
     getIt.registerLazySingleton<SavedRepository>(()=>SavedRepositoryImpl(
      localStorage: getIt<LocalStorage>(),
      ));

      getIt.registerLazySingleton<GetSavedArticlesUsecase>(
        () => GetSavedArticlesUsecase(getIt<SavedRepository>()),
      );
      getIt.registerLazySingleton<SaveArticleUsecase>(
        () => SaveArticleUsecase(getIt<SavedRepository>()),
      );
      getIt.registerLazySingleton<RemoveArticleUsecase>(
        () => RemoveArticleUsecase(getIt<SavedRepository>()),
      );

      getIt.registerFactory<SavedBloc>(()=>SavedBloc(
        getSavedArticlesUseCase: getIt<GetSavedArticlesUsecase>(),
        saveArticleUsecase: getIt<SaveArticleUsecase>(),
        removeSavedArticle: getIt<RemoveArticleUsecase>(),
      ));

}
