import 'package:dartz/dartz.dart';
import 'package:newsflow/core/error/exceptions.dart';
import 'package:newsflow/core/error/failures.dart';
import 'package:newsflow/core/network/network_info.dart';
import 'package:newsflow/core/storage/local_storage.dart';
import 'package:newsflow/core/utils/app_config.dart';
import 'package:newsflow/features/news/data/datasources/news_remote_datasource.dart';
import 'package:newsflow/features/news/data/models/article_model.dart';
import 'package:newsflow/features/news/domain/entities/article_entity.dart';
import 'package:newsflow/features/news/domain/entities/news_result.dart';
import 'package:newsflow/features/news/domain/repositories/news_repository.dart';

/// Implementation of [NewsRepository]
/// Coordinates between remote datasource and local cache
class NewsRepositoryImpl implements NewsRepository {
  final NewsRemoteDataSource _remoteDatasource;
  final LocalStorage _localStorage;
  final NetworkInfo _networkInfo;

  NewsRepositoryImpl({
    required NewsRemoteDataSource remoteDatasource,
    required LocalStorage localStorage,
    required NetworkInfo networkInfo,
  })  : _remoteDatasource = remoteDatasource,
        _localStorage = localStorage,
        _networkInfo = networkInfo;

  @override
  Future<Either<Failure, NewsResult>> getTopHeadlines({
    required String category,
    required int page,
    required int pageSize,
  }) async {
    // No internet — try cache first
    if (!await _networkInfo.isConnected) {
      final cachedMaps = _localStorage.getAllSavedArticles();
      if (cachedMaps.isNotEmpty) {
        final articles = cachedMaps
            .map((map) => ArticleModel.fromMap(map).toEntity())
            .toList();
        return Right(NewsResult(
          articles: articles,
          totalResults: articles.length,
        ));
      }
      return const Left(NetworkFailure('No internet connection'));
    }

    try {
      final result = await _remoteDatasource.fetchTopHeadlines(
        category: category,
        page: page,
        pageSize: pageSize,
        apiKey: AppConfig.apiKey,
      );

      // Cache first page only
      if (page == 1) {
        await _localStorage.cacheArticles(
          result.articles.map((a) => a.toMap()).toList(),
        );
      }

      return Right(NewsResult(
        articles: result.articles.map((a) => a.toEntity()).toList(),
        totalResults: result.totalResults,
      ));
    } on NetworkException {
      return const Left(NetworkFailure('No internet connection'));
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    } on AuthException {
      return const Left(AuthFailure('Unauthorized'));
    }
  }

  @override
  Future<Either<Failure, List<ArticleEntity>>> getCachedArticles() async {
    try {
      final cachedMaps = _localStorage.getAllSavedArticles();
      final articles = cachedMaps
          .map((map) => ArticleModel.fromMap(map).toEntity())
          .toList();
      return Right(articles);
    } on CacheException catch (e) {
      return Left(CacheFailure(e.message));
    }
  }
}
