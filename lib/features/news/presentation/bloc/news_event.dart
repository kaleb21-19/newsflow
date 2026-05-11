part of 'news_bloc.dart';

sealed class NewsEvent extends Equatable {
  const NewsEvent();
  
  @override
  List<Object?> get props => [];
}

/// Event to request a new page of news
final class NewsPageRequested extends NewsEvent {
  final int page;
  const NewsPageRequested({required this.page});
  @override
    List<Object?> get props => [page];
  
}
/// Event to refresh the news
// Correct
final class NewsRefreshRequested extends NewsEvent {
  const NewsRefreshRequested();
}

/// Event to change the news category`  
final class NewsCategoryChanged extends NewsEvent {
  final String category;
  const NewsCategoryChanged({required this.category});

  @override
  List<Object?> get props => [category];
}





