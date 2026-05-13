import 'package:dartz/dartz.dart';
import 'package:newsflow/core/error/failures.dart';
import 'package:newsflow/features/news/domain/entities/article_entity.dart';

abstract class SavedRepository {
  // Add methods for saved articles operations
  Future<Either<Failure,List<ArticleEntity>>> getSavedArticles();
  Future<Either<Failure,void>> saveArticle({required ArticleEntity article});
  Future<Either<Failure,void>> removeSavedArticle({required String articleId});
}
