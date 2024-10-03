import 'package:either_dart/either.dart';
import 'package:phu_tho_mobile/application/enums/type_action.dart';
import 'package:phu_tho_mobile/data/data_sources/api/api_client.dart';
import 'package:phu_tho_mobile/data/data_sources/api/api_response.dart';
import 'package:phu_tho_mobile/di.dart';
import 'package:phu_tho_mobile/domain/models/request/business/business_request.dart';
import 'package:phu_tho_mobile/domain/models/response/business/business_response.dart';
import 'package:phu_tho_mobile/domain/repositories/business_repository.dart';

class BusinessRepositoryImpl extends BusinessRepository {
  final _api = getIt.get<ApiClient>();

  @override
  Future<Either<String, ListDataResponse<BusinessResponse>>> getBusiness(
      BusinessRequest request, TypeAction type) async {
    try {
      ApiResponse<ListDataResponse<BusinessResponse>> response;
      switch (type) {
        case TypeAction.manage:
          response = await _api.getMangeBusiness(request);
          break;
        default:
          response = await _api.getBusiness(request);
          break;
      }

      if (response.status && response.data != null) {
        return Right(response.data!);
      }
      return Left(response.message);
    } catch (e) {
      return Left(e.toString());
    }
  }

  @override
  Future<Either<String, BusinessResponse>> getDetailBusiness(
      int id, TypeAction type) async {
    try {
      ApiResponse<BusinessResponse> response;
      switch (type) {
        case TypeAction.manage:
          response = await _api.getDetailMangeBusiness(id);
          break;
        default:
          response = await _api.getDetailBusiness(id);
          break;
      }
      if (response.status && response.data != null) {
        return Right(response.data!);
      }
      return Left(response.message);
    } catch (e) {
      return Left(e.toString());
    }
  }

  @override
  Future<Either<String, List<BusinessResponse>>> getHotBusiness() async {
    try {
      final response = await _api.getHotBusiness();
      if (response.status && response.data != null) {
        return Right(response.data!);
      }
      return Left(response.message);
    } catch (e) {
      return Left(e.toString());
    }
  }

  @override
  Future<Either<String, String>> deleteBusiness(int id) async {
    try {
      final response = await _api.deleteMangeBusiness(id);
      if (response.status) {
        return Right(response.message);
      }
      return Left(response.message);
    } catch (e) {
      return Left(e.toString());
    }
  }

  @override
  Future<Either<String, ListDataResponse<BusinessResponse>>>
      getBusinessByIdIndustrialPark(BusinessRequest request) async {
    try {
      ApiResponse<ListDataResponse<BusinessResponse>> response =
          await _api.getBusinessByIdIndustrialPark(request);
      ;
      if (response.status && response.data != null) {
        return Right(response.data!);
      }
      return Left(response.message);
    } catch (e) {
      return Left(e.toString());
    }
  }
}
