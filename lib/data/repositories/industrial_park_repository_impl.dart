import 'package:either_dart/either.dart';
import 'package:phu_tho_mobile/application/enums/type_industrial_park.dart';
import 'package:phu_tho_mobile/data/data_sources/api/api_client.dart';
import 'package:phu_tho_mobile/data/data_sources/api/api_response.dart';
import 'package:phu_tho_mobile/di.dart';
import 'package:phu_tho_mobile/domain/models/request/industrial_park/industrial_park_request.dart';
import 'package:phu_tho_mobile/domain/models/response/industrial_park/industrial_park_response.dart';
import 'package:phu_tho_mobile/domain/repositories/industrial_park_repository.dart';

class IndustrialParkRepositoryImpl implements IndustrialParkRepository {
  final api = getIt.get<ApiClient>();

  @override
  Future<Either<String, ListDataResponse<IndustrialParkResponse>>>
      getIndustrialParks(
          TypeIndustrialPark type, IndustrialParkRequest request) async {
    try {
      late final ApiResponse<ListDataResponse<IndustrialParkResponse>> response;
      if (type == TypeIndustrialPark.industrialPark) {
        response = await api.getIndustrialPark(request);
      } else {
        response = await api.getManageIndustrialPark(request);
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
  Future<Either<String, bool>> deleteIndustrialPark(int id) async {
    try {
      final response = await api.deleteIndustrialPark(id);
      if (response.status) {
        return Right(response.status);
      }
      return Left(response.message);
    } catch (e) {
      return Left(e.toString());
    }
  }
}
