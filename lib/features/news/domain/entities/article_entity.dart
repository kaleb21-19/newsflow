import 'package:equatable/equatable.dart';

class ArticleEntity extends Equatable {

  final String id;
  final String title;
  final String description;
  final String content;
  final String url;
  final String imageUrl;
  final String source;
  final String author;
  final DateTime publishedAt;
  final bool isBookmarked;

  const ArticleEntity({
    required this.id,
    required this.title,
    required this.description,
    required this.content,
    required this.url,
    required this.imageUrl,
    required this.source,
    required this.author,
    required this.publishedAt,
    required this.isBookmarked,
  });
  
ArticleEntity copyWith({
  String? id,
  String? title,
  String? description,
  String? content,
  String? url,
  String? imageUrl,
  String? source,
  String? author,
  DateTime? publishedAt,
  bool? isBookmarked,
}) {
  return ArticleEntity(
    id: id ?? this.id,
    title: title ?? this.title,
    description: description ?? this.description,
    content: content ?? this.content,
    url: url ?? this.url,
    imageUrl: imageUrl ?? this.imageUrl,
    source: source ?? this.source,
    author: author ?? this.author,
    publishedAt: publishedAt ?? this.publishedAt,
    isBookmarked: isBookmarked ?? this.isBookmarked,
  );
}

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


  @override
  List<Object?> get props => [id, title, description, content, url, imageUrl, source, author, publishedAt, isBookmarked];
}
