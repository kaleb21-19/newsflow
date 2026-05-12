import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:newsflow/core/di/injection.dart';
import 'package:newsflow/core/router/route_names.dart';
import 'package:newsflow/core/theme/app_colors.dart';
import 'package:newsflow/core/theme/app_spacing.dart';
import 'package:newsflow/features/news/domain/entities/article_entity.dart';
import 'package:newsflow/features/news/presentation/bloc/news_bloc.dart';
import 'package:newsflow/features/news/presentation/widgets/article_card.dart';
class NewsTab extends StatelessWidget {
const NewsTab({super.key});
@override
Widget build(BuildContext context) {
return  BlocProvider(
create: (context) => getIt<NewsBloc>(),
child: NewsView(),
    );
  }
}
class NewsView extends StatefulWidget {
const NewsView({super.key});
@override
State<NewsView> createState() => _NewsViewState();
}
class _NewsViewState extends State<NewsView> {
late final PagingController<int, ArticleEntity> _pagingController;


static const _categories = [
  'general',
  'technology',
  'business',
  'sports',
  'health',
  'science',
  'entertainment',
];
@override
void initState() {
super.initState();
_pagingController=PagingController(
getNextPageKey: (state) {
if(state.pages==null||state.pages!.isEmpty)return 1;
final isLastPage=state.pages!.last;
if(isLastPage.length<20)return null;
return state.pages!.length + 1;
      }, 
fetchPage: (pageKey)async
       {  
final currenState=context.read<NewsBloc>().state;
if(currenState.hasReachedEnd&&pageKey>1){
return <ArticleEntity>[];
           }
context.read<NewsBloc>().add(NewsPageRequested(page: pageKey));
final result=await context.read<NewsBloc>().stream.firstWhere(
            (state) {
return state.status == NewsStatus.success || state.status == NewsStatus.failure;
            }
          ).timeout(const Duration(seconds: 10));
if(result.status==NewsStatus.failure){
throw Exception(result.errorMessage);
             }
return result.latestArticles;
        }
    );
  }
@override
void dispose() {
_pagingController.dispose(  );
super.dispose();
  }



void _onCategoryChanged(String category) {
  context.read<NewsBloc>().add(NewsCategoryChanged(category: category));
  _pagingController.refresh();
}
Widget build(BuildContext context) {
return Scaffold(
appBar: AppBar(
title: const Text('News'),
      ),
body: Column(
children: [
  SizedBox(
    height: 42,
    child: ListView.builder(
      scrollDirection: Axis.horizontal,
      itemCount: _categories.length,
      itemBuilder: (context, index) {
        final category = _categories[index];
        return BlocBuilder<NewsBloc, NewsState>(
          buildWhen: (previous, current) {
            return previous.selectedCategory != current.selectedCategory;
          },
          builder: (context, state) {
            final isSelected = state.selectedCategory == category;
            return Padding(
              padding: EdgeInsets.symmetric(horizontal: AppSpacing.sm),
              child: ChoiceChip(
                
                  label: Text(category.toUpperCase()),
                  selected: isSelected,
                  onSelected: (_) => _onCategoryChanged(category),
                  selectedColor: AppColors.primary,
                 labelStyle: TextStyle(
  color: isSelected ? AppColors.white : AppColors.textPrimary,
  fontSize: 12,
),
                  ),
            );
          }
        );
      },
    ),
  ),
Expanded(child: RefreshIndicator(
  onRefresh: () async {
     context.read<NewsBloc>().add(const NewsRefreshRequested());
  _pagingController.refresh();
    await context.read<NewsBloc>().stream.firstWhere(
    (s) => s.status != NewsStatus.loading,
  );
  },
  child: PagingListener<int, ArticleEntity>(
  controller: _pagingController,
  builder: (context,state,fetchPage){
  return PagedListView<int, ArticleEntity>(
    padding: EdgeInsets.all(AppSpacing.pagePadding),
  state: state, 
  fetchNextPage: fetchPage,
  builderDelegate: PagedChildBuilderDelegate(
  itemBuilder: (context,item,index){
  return Padding(padding:EdgeInsets.only(bottom: AppSpacing.md),
  child: ArticleCard(article: item, onTap: () { 
    context.push(RouteNames.articleDetail, extra: item);
   },));
                    },
  firstPageProgressIndicatorBuilder: (context)=>const Center(child: CircularProgressIndicator()),
  newPageProgressIndicatorBuilder: (context)=>const Center(child: CircularProgressIndicator()),
  noItemsFoundIndicatorBuilder: (context) => Text('No articles found'),
  noMoreItemsIndicatorBuilder: (context) =>  Text('You have reached the end'),
  firstPageErrorIndicatorBuilder: (context) =>TextButton(onPressed: _pagingController.refresh, child: const Text('Retry')),
  //newPageErrorIndicatorBuilder: (context) => TextButton(onPressed: () => _pagingController.retryLastFailedRequest(), child: const Text('Retry')),
                   )
                  );
               }),
))
        ],
      ),
    );
  }
}
