part of 'saved_bloc.dart';

/// Base class for all saved events
sealed class SavedEvent extends Equatable {
  const SavedEvent();
}

class LoadSavedArticles extends SavedEvent {
  const LoadSavedArticles();
  
  @override
  
  List<Object?> get props => [];
}

class RemoveSavedArticle extends SavedEvent {
  final String articleId;
  
  const RemoveSavedArticle({required this.articleId});
  
  @override
  List<Object?> get props => [articleId];
}
class SavedArticle extends SavedEvent {
  final ArticleEntity article;
  
  const SavedArticle({required this.article});
  
  @override
  List<Object?> get props => [article];
}
