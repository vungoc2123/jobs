import 'package:either_dart/either.dart';
import 'package:phu_tho_mobile/data/data_sources/api/api_client.dart';
import 'package:phu_tho_mobile/data/data_sources/api/api_response.dart';
import 'package:phu_tho_mobile/di.dart';
import 'package:phu_tho_mobile/domain/models/request/economic_activity/economic_activity_request.dart';
import 'package:phu_tho_mobile/domain/models/response/ecocomic_activity/economic_activity_response.dart';
import 'package:phu_tho_mobile/domain/repositories/economic_activity_repository.dart';

class EconomicActivityRepositoryImpl implements EconomicActivityRepository {
  final api = getIt.get<ApiClient>();

  @override
  Future<Either<String, ListDataResponse<EconomicActivityResponse>>>
      getEconomicActivity(EconomicActivityRequest request) async {
    try {
      final response = await api.getEconomicActivity(request);
      if (response.status && response.data != null) {
        return Right(response.data!);
      }
      return Left(response.message);
    } catch (e) {
      return Left(e.toString());
    }
  }
}
