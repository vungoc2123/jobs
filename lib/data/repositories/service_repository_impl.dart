import 'package:either_dart/either.dart';
import 'package:phu_tho_mobile/data/data_sources/api/api_client.dart';
import 'package:phu_tho_mobile/data/data_sources/api/api_response.dart';
import 'package:phu_tho_mobile/di.dart';
import 'package:phu_tho_mobile/domain/models/request/service/service_request.dart';
import 'package:phu_tho_mobile/domain/models/response/service/business_service.dart';
import 'package:phu_tho_mobile/domain/repositories/service_repository.dart';

class ServiceRepositoryImpl implements ServiceRepository{
  final api = getIt.get<ApiClient>();
  @override
  Future<Either<String, ListDataResponse<BusinessServiceResponse>>> getBusinessService(ServiceRequest request) async {
    try{
      final response = await api.getCostService(request);
      if(response.status && response.data != null){
        return Right(response.data!);
      }
      return Left(response.message);
    }catch (e){
      return Left(e.toString());
    }
  }

}