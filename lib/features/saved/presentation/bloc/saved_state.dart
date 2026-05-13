part of 'saved_bloc.dart';
enum SavedStatus {
  initial,    // ← add this
  loading,
  success,
  failure,
}

class SavedState extends Equatable {
  final SavedStatus status;
  final List<ArticleEntity> articles;
  final String errorMessage;
  
  const SavedState({
     this.status = SavedStatus.initial,
     this.articles = const [],
     this.errorMessage = '',
  });

  SavedState copyWith({
    SavedStatus? status,
    List<ArticleEntity>? articles,
    String? errorMessage,
  }) {
    return SavedState(
      status: status ?? this.status,
      articles: articles ?? this.articles,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
  
  @override
  List<Object?> get props => [status, articles,errorMessage];
}
