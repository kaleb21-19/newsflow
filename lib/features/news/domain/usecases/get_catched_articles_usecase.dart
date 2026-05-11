import 'package:dartz/dartz.dart';
import 'package:newsflow/core/error/failures.dart';
import 'package:newsflow/core/usecases/usecase.dart';
import 'package:newsflow/features/news/domain/entities/article_entity.dart';
import 'package:newsflow/features/news/domain/repositories/news_repository.dart';

/// Use case to get caught articles from local storage
class GetCachedArticlesUseCase extends UseCase<List<ArticleEntity>, NoParams>{
  final NewsRepository _newsRepository;
  
  GetCachedArticlesUseCase(this._newsRepository);
  
  @override
  Future<Either<Failure, List<ArticleEntity>>> call(NoParams params)  {
    return  _newsRepository.getCachedArticles();
  }
  
} 
