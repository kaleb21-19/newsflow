
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:newsflow/core/error/failures.dart';
import 'package:newsflow/core/usecases/usecase.dart';
import 'package:newsflow/features/saved/domain/repositories/saved_repository.dart';

class RemoveArticleUsecase extends UseCase<void, RemoveArticleParams> {
  final SavedRepository savedRepository;
  
  RemoveArticleUsecase(this.savedRepository);
  
  @override
  Future<Either<Failure, void>> call(RemoveArticleParams params) {
  return savedRepository.removeSavedArticle(
    articleId: params.articleId);
  }
  
}

class RemoveArticleParams extends Equatable {
  final String articleId;
  
  RemoveArticleParams({required this.articleId});
  
  @override
  // TODO: implement props
  List<Object?> get props => [articleId];
}
