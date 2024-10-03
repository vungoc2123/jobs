import 'package:either_dart/either.dart';
import 'package:phu_tho_mobile/data/data_sources/api/api_client.dart';
import 'package:phu_tho_mobile/data/data_sources/api/api_response.dart';
import 'package:phu_tho_mobile/di.dart';
import 'package:phu_tho_mobile/domain/models/request/trading_job/trading_job_request.dart';
import 'package:phu_tho_mobile/domain/models/response/trading_job_response/trading_job_response.dart';
import 'package:phu_tho_mobile/domain/repositories/trading_job_repository.dart';

class TradingJobRepositoryImpl extends TradingJobRepository {
  final api = getIt.get<ApiClient>();

  @override
  Future<Either<String, ListDataResponse<TradingJobResponse>>> getTradingJobs(
      TradingJobRequest request) async {
    try {
      final response = await api.getTradingJobs(request);
      if (response.status && response.data != null) {
        return Right(response.data!);
      }
      return Left(response.message);
    } catch (e) {
      return Left(e.toString());
    }
  }
}
