import 'package:newsflow/features/news/data/datasources/news_remote_datasource.dart';
import 'package:newsflow/features/news/data/models/article_model.dart';
import 'package:newsflow/features/news/data/models/news_response_model.dart';




class MockNewsDatasourceImpl implements NewsRemoteDataSource {
  
  
  MockNewsDatasourceImpl();
  
  
  @override
  Future<NewsResponseModel> fetchTopHeadlines({
    required int page,
    required int pageSize,
    required String apiKey,
    required String category,
  }) async {
     await Future.delayed(const Duration(milliseconds: 500));

     if((page-1) * pageSize >= 50){
      return const NewsResponseModel(totalResults: 50, articles: []);
     }
    
    final data=List.generate(20,
      (index) =>ArticleModel(
  title: 'Article title number $index on $category',
  description: 'This is a description for article $index',
  content: 'Full content for article $index goes here...',
  url: 'https://newsflow.com/article/$page/$index',
  imageUrl: 'https://picsum.photos/seed/$index/800/400',
  source: ['CNN', 'BBC', 'Reuters', 'AP News'][index % 4],
  author: ['John Smith', 'Jane Doe', 'Bob Wilson', 'Alice Brown'][index % 4],
  publishedAt: DateTime.now().subtract(Duration(hours: index)),
  isBookmarked: false,
)
     );

     return NewsResponseModel(totalResults: 50, articles: data);
  }
  
}
