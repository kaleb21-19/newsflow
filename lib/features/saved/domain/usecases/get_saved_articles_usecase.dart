
import 'package:dartz/dartz.dart';
import 'package:newsflow/core/error/failures.dart';
import 'package:newsflow/core/usecases/usecase.dart';
import 'package:newsflow/features/news/domain/entities/article_entity.dart';
import 'package:newsflow/features/saved/domain/repositories/saved_repository.dart';

class GetSavedArticlesUsecase extends UseCase<List<ArticleEntity>, NoParams> {
  final SavedRepository savedRepository;
  
  GetSavedArticlesUsecase(this.savedRepository);
  
  @override
  Future<Either<Failure, List<ArticleEntity>>> call(NoParams params) {
  return savedRepository.getSavedArticles();
  }
  
}
