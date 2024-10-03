import 'package:either_dart/either.dart';
import 'package:phu_tho_mobile/data/data_sources/api/api_client.dart';
import 'package:phu_tho_mobile/data/data_sources/api/api_response.dart';
import 'package:phu_tho_mobile/di.dart';
import 'package:phu_tho_mobile/domain/models/request/advise/advise_request.dart';
import 'package:phu_tho_mobile/domain/models/response/advise/advise_response.dart';
import 'package:phu_tho_mobile/domain/repositories/advise_repository.dart';

class AdviseRepositoryImpl implements AdviseRepository {
  final api = getIt.get<ApiClient>();

  @override
  Future<Either<String, ListDataResponse<AdviseResponse>>> getAllAdvise(
      AdviseRequest request) async {
    try {
      final response = await api.getAllAdvise(request);
      if (response.status && response.data != null) {
        return Right(response.data!);
      }
      return Left(response.message);
    } catch (e) {
      return Left(e.toString());
    }
  }
}
