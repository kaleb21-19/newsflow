import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:newsflow/core/error/failures.dart';
import 'package:newsflow/core/usecases/usecase.dart';
import 'package:newsflow/features/news/domain/entities/news_result.dart';
import 'package:newsflow/features/news/domain/repositories/news_repository.dart';

class GetTopHeadlinesUseCase extends UseCase<NewsResult, TopHeadlinesParams> {
   final NewsRepository _newsRepository;

   GetTopHeadlinesUseCase(this._newsRepository);

  @override
  Future<Either<Failure, NewsResult>> call(TopHeadlinesParams params) async {
   return _newsRepository.getTopHeadlines(
    category: params.category,
    page: params.page,
    pageSize: params.pageSize,
   );
  }

}


class TopHeadlinesParams extends Equatable {
  final String category;
  final int page;
  final int pageSize;
  
  const TopHeadlinesParams({
     this.category='general',
    required this.page,
    required this.pageSize,
  });
  
  @override
  List<Object?> get props => [category, page, pageSize];
}
