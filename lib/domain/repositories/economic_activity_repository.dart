import 'package:either_dart/either.dart';
import 'package:phu_tho_mobile/data/data_sources/api/api_response.dart';
import 'package:phu_tho_mobile/domain/models/request/economic_activity/economic_activity_request.dart';
import 'package:phu_tho_mobile/domain/models/response/ecocomic_activity/economic_activity_response.dart';

abstract class EconomicActivityRepository {
  Future<Either<String, ListDataResponse<EconomicActivityResponse>>>
      getEconomicActivity(EconomicActivityRequest request);
}
