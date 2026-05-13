import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:newsflow/features/news/domain/entities/article_entity.dart';

part 'article_model.freezed.dart';
part 'article_model.g.dart';

/// Article data model — handles JSON parsing and Hive storage
@freezed
abstract class ArticleModel with _$ArticleModel {
  const ArticleModel._();

  const factory ArticleModel({
    required String title,
    required String description,
    required String content,
    required String url,
    @JsonKey(name: 'urlToImage') required String imageUrl,
    required String source,
    required String author,
    required DateTime publishedAt,
    @JsonKey(includeFromJson: false, includeToJson: false)
    @Default(false) bool isBookmarked,
  }) = _ArticleModel;

  // This is what json_serializable needs to see — simple arrow syntax
factory ArticleModel.fromJson(Map<String, dynamic> json) =>
    _$ArticleModelFromJson(_flattenSource(json));

// Static helper that flattens the source before json_serializable parses
static Map<String, dynamic> _flattenSource(Map<String, dynamic> json) {
  final sourceName =
      (json['source'] as Map<String, dynamic>?)?['name']
          as String? ?? 'Unknown';
  return {
    ...json,
    'source': sourceName,
  };
}

  /// Convert to domain entity
  ArticleEntity toEntity() {
    return ArticleEntity(
      id: url,
      title: title,
      description: description,
      content: content,
      url: url,
      imageUrl: imageUrl,
      source: source,
      author: author,
      publishedAt: publishedAt,
      isBookmarked: isBookmarked,
    );
  }

  /// Convert to Map for Hive storage
  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'description': description,
      'content': content,
      'url': url,
      'imageUrl': imageUrl,
      'source': source,
      'author': author,
      'publishedAt': publishedAt.toIso8601String(),
      'isBookmarked': isBookmarked,
    };
  }

  /// Create from Hive Map
  factory ArticleModel.fromMap(Map<String, dynamic> map) {
    return ArticleModel(
      title: map['title'] as String? ?? '',
      description: map['description'] as String? ?? '',
      content: map['content'] as String? ?? '',
      url: map['url'] as String? ?? '',
      imageUrl: map['imageUrl'] as String? ?? '',
      source: map['source'] as String? ?? '',
      author: map['author'] as String? ?? '',
      publishedAt: DateTime.parse(map['publishedAt'] as String),
      isBookmarked: map['isBookmarked'] as bool? ?? false,
    );
  }
}