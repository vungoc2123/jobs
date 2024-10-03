import 'package:either_dart/either.dart';
import 'package:phu_tho_mobile/data/data_sources/api/api_client.dart';
import 'package:phu_tho_mobile/data/data_sources/api/api_response.dart';
import 'package:phu_tho_mobile/di.dart';
import 'package:phu_tho_mobile/domain/models/request/news/news_request.dart';
import 'package:phu_tho_mobile/domain/models/response/news/news_response.dart';
import 'package:phu_tho_mobile/domain/repositories/news_repository.dart';

class NewsRepositoryImpl implements NewsRepository{

  final _api = getIt.get<ApiClient>();
  @override
  Future<Either<String, ListDataResponse<NewsResponse>>> getNewCommunication(NewsRequest request) async {
    try{
      final response = await _api.getNewsCommunication(request);
      if(response.status && response.data != null){
        return Right(response.data!);
      }
      return Left(response.message);
    }catch (e){
      return Left(e.toString());
    }
  }

  @override
  Future<Either<String, List<NewsResponse>>> getNewsSame(int id, int quantity) async
  {
    try{
      final response = await _api.getNewsSame(id,quantity);
      if(response.status && response.data != null){
        return Right(response.data!);
      }
      return Left(response.message);
    }catch (e){
      return Left(e.toString());
    }
  }

  @override
  Future<Either<String, ListDataResponse<NewsResponse>>> getNewsAdvise(NewsRequest request) async{
    try{
      final response = await _api.getNewsAdvise(request);
      if(response.status && response.data != null){
        return Right(response.data!);
      }
      return Left(response.message);
    }catch (e){
      return Left(e.toString());
    }
  }

  @override
  Future<Either<String, ListDataResponse<NewsResponse>>> getNewsFindingPeople(NewsRequest request) async{
    try{
      final response = await _api.getNewsFindingPeople(request);
      if(response.status && response.data != null){
        return Right(response.data!);
      }
      return Left(response.message);
    }catch (e){
      return Left(e.toString());
    }
  }

  @override
  Future<Either<String, ListDataResponse<NewsResponse>>> getNewsIntroduction(NewsRequest request) async{
    try{
      final response = await _api.getNewsIntroduction(request);
      if(response.status && response.data != null){
        return Right(response.data!);
      }
      return Left(response.message);
    }catch (e){
      return Left(e.toString());
    }
  }

  @override
  Future<Either<String, ListDataResponse<NewsResponse>>> getNewsJobSeekers(NewsRequest request) async{
    try{
      final response = await _api.getNewsJobSeekers(request);
      if(response.status && response.data != null){
        return Right(response.data!);
      }
      return Left(response.message);
    }catch (e){
      return Left(e.toString());
    }
  }

  @override
  Future<Either<String, ListDataResponse<NewsResponse>>> getNewsSupply(NewsRequest request ) async{
    try{
      final response = await _api.getNewsSupply(request);
      if(response.status && response.data != null){
        return Right(response.data!);
      }
      return Left(response.message);
    }catch (e){
      return Left(e.toString());
    }
  }

  @override
  Future<Either<String, ListDataResponse<NewsResponse>>> getNewsEmploymentStatus(NewsRequest request) async{
    try{
      final response = await _api.getNewsEmploymentStatus(request);
      if(response.status && response.data != null){
        return Right(response.data!);
      }
      return Left(response.message);
    }catch (e){
      return Left(e.toString());
    }
  }

  @override
  Future<Either<String, ListDataResponse<NewsResponse>>> getForecast(NewsRequest request) async {
    try{
      final response = await _api.getForecast(request);
      if(response.status && response.data != null){
        return Right(response.data!);
      }
      return Left(response.message);
    }catch (e){
      return Left(e.toString());
    }
  }

}