import 'package:either_dart/either.dart';
import 'package:phu_tho_mobile/data/data_sources/api/api_response.dart';
import 'package:phu_tho_mobile/domain/models/request/news/news_request.dart';
import 'package:phu_tho_mobile/domain/models/response/news/news_response.dart';

abstract class NewsRepository {
  Future<Either<String, ListDataResponse<NewsResponse>>> getNewCommunication(
      NewsRequest request);

  Future<Either<String, List<NewsResponse>>>
      getNewsSame(int id, int quantity);

  Future<Either<String, ListDataResponse<NewsResponse>>> getNewsAdvise(
      NewsRequest request);

  Future<Either<String, ListDataResponse<NewsResponse>>> getNewsIntroduction(
      NewsRequest request);

  Future<Either<String, ListDataResponse<NewsResponse>>> getNewsSupply(
      NewsRequest request);

  Future<Either<String, ListDataResponse<NewsResponse>>> getNewsJobSeekers(
      NewsRequest request);

  Future<Either<String, ListDataResponse<NewsResponse>>> getNewsFindingPeople(
      NewsRequest request);

  Future<Either<String, ListDataResponse<NewsResponse>>>
      getNewsEmploymentStatus(NewsRequest request);

  Future<Either<String, ListDataResponse<NewsResponse>>>
  getForecast(NewsRequest request);
}
