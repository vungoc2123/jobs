import 'package:either_dart/either.dart';
import 'package:phu_tho_mobile/application/enums/type_industrial_park.dart';
import 'package:phu_tho_mobile/data/data_sources/api/api_response.dart';
import 'package:phu_tho_mobile/domain/models/request/industrial_park/industrial_park_request.dart';
import 'package:phu_tho_mobile/domain/models/response/industrial_park/industrial_park_response.dart';

abstract class IndustrialParkRepository {
  Future<Either<String, ListDataResponse<IndustrialParkResponse>>>
      getIndustrialParks(
          TypeIndustrialPark type, IndustrialParkRequest request);

  Future<Either<String, bool>> deleteIndustrialPark(int id);
}
