import 'package:flutter/material.dart';
import 'package:newsflow/core/theme/app_colors.dart';
import 'package:newsflow/core/theme/app_spacing.dart';
import 'package:newsflow/core/theme/app_text_styles.dart';
import 'package:newsflow/features/news/domain/entities/article_entity.dart';
import 'package:timeago/timeago.dart' as timeago;

class ArticleDetailPage extends StatelessWidget {
  final ArticleEntity article;
  
  const ArticleDetailPage({super.key, required this.article});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
   appBar: AppBar(
  title: const Text(''),
  actions: [
    IconButton(
      icon: Icon(
        article.isBookmarked
            ? Icons.bookmark
            : Icons.bookmark_outline,
      ),
      onPressed: () => print('bookmark tapped'),
    ),
  ],
),
      
      body: SingleChildScrollView(
      
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
            Image.network(
              article.imageUrl,
              height: 250,
              width: double.infinity,
              errorBuilder: (context, error, stackTrace) {
                return Container(
                  height: 250,
                  width: double.infinity,
                  color: Colors.grey[300],
                  child: const Icon(Icons.image, size: 50, color: Colors.grey),
                );
              },
            ),
            const SizedBox(height: AppSpacing.md),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: AppSpacing.pagePadding),
              child: Column(
                
                children: [
              Row(
                children: [
                  Text(article.source),
                  const SizedBox(width: AppSpacing.sm),
                  Text(timeago.format(article.publishedAt)),
                ],
              ),  
              const SizedBox(height: AppSpacing.md),
              Text(article.title,style: AppTextStyles.headingLarge,),
              const SizedBox(height: AppSpacing.md),
              Text(
                'By ${article.author}',
                style: AppTextStyles.bodyMedium.copyWith(
                  color: AppColors.textSecondary,
                ),
              ),
                        Text(article.description, style: AppTextStyles.bodyMedium),
              const SizedBox(height: AppSpacing.md),
              Text(article.content, style: AppTextStyles.bodyMedium),
              ],
                        ),
            ),
        ]),
      ),
    );
  }
}
