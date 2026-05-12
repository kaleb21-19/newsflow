
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:newsflow/core/error/failures.dart';
import 'package:newsflow/core/usecases/usecase.dart';
import 'package:newsflow/features/news/domain/entities/article_entity.dart';
import 'package:newsflow/features/saved/domain/repositories/saved_repository.dart';

class SaveArticleUsecase extends UseCase<void, SaveArticleParams> {
  final SavedRepository savedRepository;
  
  SaveArticleUsecase(this.savedRepository);
  
  @override
  Future<Either<Failure, void>> call(SaveArticleParams params) {
    return savedRepository.saveArticle(article: params.article);
  }
  
}

class SaveArticleParams extends Equatable {
  final ArticleEntity article;
  
  SaveArticleParams({required this.article});
  
  @override
  // TODO: implement props
  List<Object?> get props => [article];
}