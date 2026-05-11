import 'package:newsflow/core/network/api_client.dart';
import 'package:newsflow/core/network/api_endpoints.dart';
import 'package:newsflow/core/network/network_info.dart';
import 'package:newsflow/core/storage/local_storage.dart';
import 'package:newsflow/core/utils/app_config.dart';
import 'package:newsflow/features/news/data/models/news_response_model.dart';

abstract class NewsRemoteDataSource {
  Future<NewsResponseModel> fetchTopHeadlines({
     required int page,
     required int pageSize,
     required String apiKey,
     required String category
  });
} 

class NewsRemoteDataSourceImpl implements NewsRemoteDataSource {
    final ApiClient _apiClient;

  
    
    NewsRemoteDataSourceImpl({
      required ApiClient apiClient,
    }): _apiClient = apiClient;
    
     
    
  @override
  Future<NewsResponseModel> fetchTopHeadlines({
    required int page,
    required int pageSize,
    required String apiKey,
    required String category,
  })async {
      final result=await _apiClient.get(
        ApiEndpoints.topHeadlines,

        baseUrl: AppConfig.baseUrl,
           queryParameters: {
    'category': category,
      'page': page,
      'pageSize': pageSize,
      'apiKey': apiKey,
    },
      );

      return NewsResponseModel.fromJson(result as Map<String, dynamic>);



    
  
  }
  
}