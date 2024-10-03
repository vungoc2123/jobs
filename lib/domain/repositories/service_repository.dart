import 'package:either_dart/either.dart';
import 'package:phu_tho_mobile/data/data_sources/api/api_response.dart';
import 'package:phu_tho_mobile/domain/models/request/service/service_request.dart';
import 'package:phu_tho_mobile/domain/models/response/service/business_service.dart';

abstract class ServiceRepository{
  Future<Either<String,ListDataResponse<BusinessServiceResponse>>> getBusinessService(ServiceRequest request);
}