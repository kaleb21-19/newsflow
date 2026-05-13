import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:newsflow/core/router/route_names.dart';
import 'package:newsflow/core/theme/app_colors.dart';
import 'package:newsflow/core/theme/app_spacing.dart';
import 'package:newsflow/core/theme/app_text_styles.dart';
import 'package:newsflow/features/news/domain/entities/article_entity.dart';
import 'package:newsflow/features/saved/presentation/bloc/saved_bloc.dart';
import 'package:timeago/timeago.dart' as timeago;

class SavedTab extends StatelessWidget {
  const SavedTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
    appBar: AppBar(
      title: const Text('Saved'),
    ),
      body: BlocBuilder<SavedBloc,SavedState>(
        builder: (context, state) {
          
         if (state.status == SavedStatus.failure) {
  return Center(
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(state.errorMessage, style: AppTextStyles.bodyMedium),
        const SizedBox(height: AppSpacing.md),
        ElevatedButton(
          onPressed: () => context.read<SavedBloc>().add(
            const LoadSavedArticles(),
          ),
          child: const Text('Retry'),
        ),
      ],
    ),
  );
}

if (state.articles.isEmpty) {
  return Center(
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Icon(Icons.bookmark_outline, size: 64, color: AppColors.grey400),
        const SizedBox(height: AppSpacing.md),
        Text('No saved articles', style: AppTextStyles.bodyLarge),
        const SizedBox(height: AppSpacing.sm),
        Text(
          'Bookmark articles to read them later',
          style: AppTextStyles.bodySmall,
        ),
      ],
    ),
  );
}

        
         
            return ListView.builder(
              itemCount: state.articles.length,
              itemBuilder: (context, index) {
                final article = state.articles[index];
                return _savedCard(article: article, context: context);
              },
            );
           
        }),
    );
       
  }
}

Widget _savedCard({required ArticleEntity article, required BuildContext context}) {
  return Card(
    margin:  const EdgeInsets.symmetric(
      horizontal: AppSpacing.cardPadding,
      vertical: AppSpacing.cardPadding,
    ),
    elevation: 2,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(AppSpacing.cardRadius)),
    clipBehavior: Clip.antiAlias, // Ensures image respects card corners
    child: InkWell( // Use InkWell for a material ripple effect on tap
       onTap: () => context.push(RouteNames.articleDetail, extra: article),
  onLongPress: () {
    context.read<SavedBloc>().add(
      RemoveSavedArticle(articleId: article.id),
    );
  },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 1. Hero Image with Loading & Error States
          Image.network(
            article.imageUrl,
            height: 180,
            width: double.infinity,
            fit: BoxFit.cover,
            errorBuilder: (context, error, stackTrace) => Container(
              height: 180,
              color: Colors.grey[200],
              child: const Icon(Icons.broken_image, color: Colors.grey),
            ),
          ),

          // 2. Content Section
          Padding(
            padding: const EdgeInsets.all(AppSpacing.cardPadding),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Source & Date Row
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      article.source.toUpperCase(),
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 12,
                        color: Colors.blueAccent,
                      ),
                    ),
                    Text(
                      timeago.format(article.publishedAt),
                    ),
                  ],
                ),
                const SizedBox(height: AppSpacing.md),

                // Title
                Text(
                  article.title,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                    height: 1.2,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 6),

                // Description
                Text(
                  article.description,
                  style: TextStyle(color: Colors.grey[800], fontSize: 14),
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 10),

                // Author
                Row(
                  children: [
                    const Icon(Icons.person_outline, size: 14, color: Colors.grey),
                    const SizedBox(width: 4),
                    Expanded(
                      child: Text(
                        article.author,
                        style: const TextStyle(fontSize: 12, fontStyle: FontStyle.italic),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}
