part of 'news_bloc.dart';

enum NewsStatus {
  initial,
  loading,
  success,
  failure,
}


final class NewsState extends Equatable {
  final NewsStatus status;
final List<ArticleEntity> latestArticles;
  final bool hasReachedEnd;
  final bool isLoadingMore;
  final int currentPage;
  final String errorMessage;
  final String selectedCategory;

  const NewsState(
    {
       this.status=NewsStatus.initial,
       this.latestArticles=const [],
   
       this.hasReachedEnd=false, 
       this.isLoadingMore=false,
       this.currentPage=0, 
       this.errorMessage='',
       this.selectedCategory='general'});


    NewsState copyWith({
      NewsStatus? status,
      List<ArticleEntity>? latestArticles,
      bool? hasReachedEnd,
      bool? isLoadingMore,
      int? currentPage,
      String? errorMessage,
      String? selectedCategory,
    }) {
      return NewsState(
        status: status ?? this.status,
        latestArticles: latestArticles ?? this.latestArticles,
        hasReachedEnd: hasReachedEnd ?? this.hasReachedEnd,
        isLoadingMore: isLoadingMore ?? this.isLoadingMore,
        currentPage: currentPage ?? this.currentPage,
        errorMessage: errorMessage ?? this.errorMessage,
        selectedCategory: selectedCategory ?? this.selectedCategory,
      );
    }
    
      @override
      List<Object?> get props => [status, latestArticles, hasReachedEnd, isLoadingMore, currentPage, errorMessage, selectedCategory];
}



