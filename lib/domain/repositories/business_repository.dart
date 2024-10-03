import 'package:either_dart/either.dart';
import 'package:phu_tho_mobile/application/enums/type_action.dart';
import 'package:phu_tho_mobile/data/data_sources/api/api_response.dart';
import 'package:phu_tho_mobile/domain/models/request/business/business_request.dart';
import 'package:phu_tho_mobile/domain/models/response/business/business_response.dart';

abstract class BusinessRepository {
  Future<Either<String, ListDataResponse<BusinessResponse>>> getBusiness(
      BusinessRequest request, TypeAction type);

  Future<Either<String, BusinessResponse>> getDetailBusiness(
      int id, TypeAction type);

  Future<Either<String, List<BusinessResponse>>> getHotBusiness();

  Future<Either<String, String>> deleteBusiness(int id);

  Future<Either<String, ListDataResponse<BusinessResponse>>> getBusinessByIdIndustrialPark(
      BusinessRequest request);
}
