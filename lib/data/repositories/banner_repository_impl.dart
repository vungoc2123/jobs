import 'package:either_dart/either.dart';
import 'package:phu_tho_mobile/data/data_sources/api/api_client.dart';
import 'package:phu_tho_mobile/di.dart';
import 'package:phu_tho_mobile/domain/models/request/base_request/base_request.dart';
import 'package:phu_tho_mobile/domain/models/response/banner/banner_response.dart';
import 'package:phu_tho_mobile/domain/repositories/banner_repository.dart';

class BannerRepositoryImpl extends BannerRepository {
  final _api = getIt.get<ApiClient>();

  @override
  Future<Either<String, List<BannerResponse>>> getBanner() async {
    try {
      final response = await _api.getBannerPublic(const BaseRequest());
      if (response.status && response.data != null) {
        return Right(response.data!);
      }
      return Left(response.message);
    } catch (e) {
      return Left(e.toString());
    }
  }
}
