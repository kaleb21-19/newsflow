import 'package:newsflow/features/news/domain/entities/article_entity.dart';

class NewsResult {
  final List<ArticleEntity> articles;
  final int totalResults;
  
  const NewsResult({
    required this.articles,
    required this.totalResults,
  });
}