import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:newsflow/features/news/data/models/article_model.dart';

part 'news_response_model.freezed.dart';
part 'news_response_model.g.dart';

/// Wraps the full NewsAPI response
@freezed
abstract class NewsResponseModel with _$NewsResponseModel {
  const factory NewsResponseModel({
    required int totalResults,
    required List<ArticleModel> articles,
  }) = _NewsResponseModel;

  factory NewsResponseModel.fromJson(Map<String, dynamic> json) =>
      _$NewsResponseModelFromJson(_parseArticles(json));

  static Map<String, dynamic> _parseArticles(Map<String, dynamic> json) {
    final rawArticles = json['articles'] as List<dynamic>? ?? [];

    final articles = rawArticles
        .whereType<Map<String, dynamic>>()
        .map((article) => ArticleModel.fromJson(article))
        .toList();

    return {
      ...json,
      'articles': articles,
    };
  }
}