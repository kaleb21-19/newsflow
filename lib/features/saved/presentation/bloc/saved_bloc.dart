import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:newsflow/core/usecases/usecase.dart';
import 'package:newsflow/features/news/domain/entities/article_entity.dart';
import 'package:newsflow/features/saved/domain/usecases/get_saved_articles_usecase.dart';
import 'package:newsflow/features/saved/domain/usecases/remove_article_usecase.dart';
import 'package:newsflow/features/saved/domain/usecases/save_article_usecase.dart';

part 'saved_event.dart';
part 'saved_state.dart';

class SavedBloc extends Bloc<SavedEvent, SavedState> {
  final GetSavedArticlesUsecase _getSavedArticlesUseCase;
  final RemoveArticleUsecase _removeSavedArticleUseCase;
  final SaveArticleUsecase _saveArticleUseCase;

  SavedBloc({
    required GetSavedArticlesUsecase getSavedArticlesUseCase,
    required RemoveArticleUsecase removeSavedArticle,
    required SaveArticleUsecase saveArticleUsecase,
  })  : _getSavedArticlesUseCase = getSavedArticlesUseCase,
        _removeSavedArticleUseCase = removeSavedArticle,
        _saveArticleUseCase = saveArticleUsecase,
        super(const SavedState()) {
    on<LoadSavedArticles>(_onLoadSavedArticles);
    on<RemoveSavedArticle>(_onRemoveSavedArticle);
    on<SavedArticle>(_onSaveArticle);
  }

  Future<void> _onLoadSavedArticles(
    LoadSavedArticles event,
    Emitter<SavedState> emit,
  ) async {
    emit(state.copyWith(status: SavedStatus.loading));

    final result = await _getSavedArticlesUseCase(const NoParams());

    result.fold(
      (failure) => emit(state.copyWith(
        status: SavedStatus.failure,
        errorMessage: failure.message,
      )),
      (articles) => emit(state.copyWith(
        status: SavedStatus.success,
        articles: articles,
      )),
    );
  }

  Future<void> _onRemoveSavedArticle(
    RemoveSavedArticle event,
    Emitter<SavedState> emit,
  ) async {
    final result = await _removeSavedArticleUseCase(
      RemoveArticleParams(articleId: event.articleId),
    );

    result.fold(
      (failure) => emit(state.copyWith(
        status: SavedStatus.failure,
        errorMessage: failure.message,
      )),
      (_) => add(const LoadSavedArticles()),
    );
  }

  Future<void> _onSaveArticle(
    SavedArticle event,
    Emitter<SavedState> emit,
  ) async {
    final result = await _saveArticleUseCase(
      SaveArticleParams(article: event.article),
    );

    result.fold(
      (failure) => emit(state.copyWith(
        status: SavedStatus.failure,
        errorMessage: failure.message,
      )),
      (_) => add(const LoadSavedArticles()),
    );
  }
}
