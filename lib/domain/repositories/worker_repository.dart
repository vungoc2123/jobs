import 'package:either_dart/either.dart';
import 'package:phu_tho_mobile/application/enums/extract_worker.dart';
import 'package:phu_tho_mobile/data/data_sources/api/api_response.dart';
import 'package:phu_tho_mobile/domain/models/request/worker/worker_request.dart';
import 'package:phu_tho_mobile/domain/models/response/worker/detail_worker_response.dart';
import 'package:phu_tho_mobile/domain/models/response/worker/worker_response.dart';

abstract class WorkerRepository {
  Future<Either<String, ListDataResponse<WorkerResponse>>> getExtractWorkers(
      WorkerRequest request, TypeExtractWorker type);

  Future<Either<String, DetailWorkerResponse>> getExtractDetailWorkers(
      int idWorker, TypeExtractWorker type);

  Future<Either<String, ListDataResponse<WorkerResponse>>> getManageWorkers(
      {required TypeExtractWorker type, required WorkerRequest request});

  Future<Either<String, bool>> deleteManageWorker(int idWorker);

  Future<Either<String, DetailWorkerResponse>> getManageDetailWorkers(
      int idWorker);
}
