import 'package:dartz/dartz.dart';
import 'package:newsflow/core/error/failures.dart';
import 'package:newsflow/features/news/domain/entities/article_entity.dart';
import 'package:newsflow/features/news/domain/entities/news_result.dart';

abstract class NewsRepository {
  /// Get news from the API
  Future<Either<Failure, NewsResult>> getTopHeadlines({
    required String category,
    required int page,
    required int pageSize,
  });

  /// Get cached articles
  Future<Either<Failure, List<ArticleEntity>>> getCachedArticles();
}
