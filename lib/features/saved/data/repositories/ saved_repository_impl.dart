import 'package:dartz/dartz.dart';
import 'package:newsflow/core/error/exceptions.dart';
import 'package:newsflow/core/error/failures.dart';
import 'package:newsflow/core/storage/local_storage.dart';
import 'package:newsflow/features/news/data/models/article_model.dart';
import 'package:newsflow/features/news/domain/entities/article_entity.dart';
import 'package:newsflow/features/saved/domain/repositories/saved_repository.dart';

class SavedRepositoryImpl implements SavedRepository {
  final LocalStorage _localStorage;
  
  SavedRepositoryImpl({required LocalStorage localStorage}) : _localStorage = localStorage;

  @override
  Future<Either<Failure, List<ArticleEntity>>> getSavedArticles() async{
   try {
    final result=_localStorage.getAllSavedArticles();

        final articles=result.map((e)=>ArticleModel.fromMap(e).toEntity()).toList();
        return Right(articles);
   } on CacheException catch (e) {
  return Left(CacheFailure(e.message));
}
   catch (e) {
    return Left(const CacheFailure('Failed to get saved articles'));
   }
       
       
  
   
  }

  @override
  Future<Either<Failure, void>> removeSavedArticle({required String articleId}) async{
    try {
      await _localStorage.deleteSavedArticle(articleId);
      return const Right(null);
   } on CacheException catch (e) {
  return Left(CacheFailure(e.message));

    } catch (e) {
      return Left(CacheFailure('Failed to remove saved article'));
    }
  }

  @override
  Future<Either<Failure, void>> saveArticle({required ArticleEntity article}) async{
    try {
  // Convert entity to model first, then to map
final articleMap = ArticleModel(
  title: article.title,
  description: article.description,
  content: article.content,
  url: article.url,
  imageUrl: article.imageUrl,
  source: article.source,
  author: article.author,
  publishedAt: article.publishedAt,
  isBookmarked: article.isBookmarked,
).toMap();
    
    print('Article map: $articleMap');
      final articleId = articleMap['url'] as String;
      await _localStorage.saveSavedArticle(articleId, articleMap);
      return Right(null);
    } on CacheException catch (e) {
  return Left(CacheFailure(e.message));
}catch (e) {
      return Left(CacheFailure('Failed to save article'));
    }
  }
  
}
