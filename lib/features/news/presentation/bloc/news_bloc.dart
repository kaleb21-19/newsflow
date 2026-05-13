import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:equatable/equatable.dart';
import 'package:newsflow/core/usecases/usecase.dart';
import 'package:newsflow/features/news/domain/entities/article_entity.dart';
import 'package:newsflow/features/news/domain/usecases/get_catched_articles_usecase.dart';
import 'package:newsflow/features/news/domain/usecases/get_top_headlines_usecase.dart';

part 'news_event.dart';
part 'news_state.dart';

/// BLoC for managing news feed with pagination
class NewsBloc extends Bloc<NewsEvent, NewsState> {
  final GetTopHeadlinesUseCase _getTopHeadlinesUseCase;
  final GetCachedArticlesUseCase _getCachedArticlesUseCase;

  static const int _pageSize = 20;

  NewsBloc({
    required GetTopHeadlinesUseCase getTopHeadlinesUseCase,
    required GetCachedArticlesUseCase getCachedArticlesUseCase,
  })  : _getTopHeadlinesUseCase = getTopHeadlinesUseCase,
        _getCachedArticlesUseCase = getCachedArticlesUseCase,
        super(const NewsState()) {
    on<NewsPageRequested>(
      _onPageRequested,
      transformer: droppable(),
    );
    on<NewsRefreshRequested>(
      _onRefreshRequested,
      transformer: droppable(),
    );
    on<NewsCategoryChanged>(
      _onCategoryChanged,
      transformer: restartable(),
    );
  }

  Future<void> _onPageRequested(
    NewsPageRequested event,
    Emitter<NewsState> emit,
  ) async {
    // Pagination guards
    if (state.isLoadingMore) return;
    if (state.hasReachedEnd) return;

    // First page — full loading state
    // Subsequent pages — bottom spinner only
    if (event.page == 1) {
      emit(state.copyWith(status: NewsStatus.loading));
    } else {
      emit(state.copyWith(isLoadingMore: true));
    }

    final result = await _getTopHeadlinesUseCase(
      TopHeadlinesParams(
        page: event.page,
        pageSize: _pageSize,
        category: state.selectedCategory,
      ),
    );

    result.fold(
      (failure) => emit(state.copyWith(
        status: NewsStatus.failure,
        errorMessage: failure.message,
        isLoadingMore: false,
      )),
      (newsResult) {
        final hasReachedEnd =
            newsResult.articles.isEmpty ||
            newsResult.totalResults <= (event.page * _pageSize);

        emit(state.copyWith(
          status: NewsStatus.success,
          latestArticles: newsResult.articles,
          currentPage: event.page,
          hasReachedEnd: hasReachedEnd,
          isLoadingMore: false,
          errorMessage: '',
        ));
      },
    );
  }

  Future<void> _onRefreshRequested(
    NewsRefreshRequested event,
    Emitter<NewsState> emit,
  ) async {
    emit(state.copyWith(
      status: NewsStatus.loading,
      latestArticles: [],
      currentPage: 0,
      hasReachedEnd: false,
      isLoadingMore: false,
      errorMessage: '',
    ));

    add(const NewsPageRequested(page: 1));
  }

  Future<void> _onCategoryChanged(
    NewsCategoryChanged event,
    Emitter<NewsState> emit,
  ) async {
    emit(state.copyWith(
      status: NewsStatus.loading,
      selectedCategory: event.category,
      latestArticles: [],
      currentPage: 0,
      hasReachedEnd: false,
      isLoadingMore: false,
      errorMessage: '',
    ));

    add(const NewsPageRequested(page: 1));
  }
}