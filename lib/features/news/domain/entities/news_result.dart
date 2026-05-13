import 'package:newsflow/features/news/domain/entities/article_entity.dart';

/// Domain entity representing the result of a news fetch operation
class NewsResult {
  /// List of articles returned by the API
  final List<ArticleEntity> articles;
  
  /// Total number of results available (from API)
  final int totalResults;
  
  /// Constructor for NewsResult
  const NewsResult({
    required this.articles,
    required this.totalResults,
  });
}
