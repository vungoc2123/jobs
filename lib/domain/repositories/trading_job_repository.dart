import 'package:either_dart/either.dart';
import 'package:phu_tho_mobile/data/data_sources/api/api_response.dart';
import 'package:phu_tho_mobile/domain/models/request/trading_job/trading_job_request.dart';
import 'package:phu_tho_mobile/domain/models/response/trading_job_response/trading_job_response.dart';

abstract class TradingJobRepository {
  Future<Either<String, ListDataResponse<TradingJobResponse>>> getTradingJobs(
      TradingJobRequest request);
}
