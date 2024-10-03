import 'package:either_dart/either.dart';
import 'package:phu_tho_mobile/application/enums/extract_worker.dart';
import 'package:phu_tho_mobile/data/data_sources/api/api_client.dart';
import 'package:phu_tho_mobile/data/data_sources/api/api_response.dart';
import 'package:phu_tho_mobile/di.dart';
import 'package:phu_tho_mobile/domain/models/request/worker/worker_request.dart';
import 'package:phu_tho_mobile/domain/models/response/worker/detail_worker_response.dart';
import 'package:phu_tho_mobile/domain/models/response/worker/worker_response.dart';
import 'package:phu_tho_mobile/domain/repositories/worker_repository.dart';

class WorkerRepositoryImpl extends WorkerRepository {
  final _api = getIt.get<ApiClient>();

  @override
  Future<Either<String, ListDataResponse<WorkerResponse>>> getExtractWorkers(
      WorkerRequest request, TypeExtractWorker type) async {
    try {
      ApiResponse<ListDataResponse<WorkerResponse>> response;
      switch (type) {
        case TypeExtractWorker.vnInForeign:
          response = await _api.getExtractWorkerVnCitizen(request);
          break;
        case TypeExtractWorker.inBusiness:
          response = await _api.getExtractWorkersInBusiness(request);
          break;
        case TypeExtractWorker.foreignInVn:
          response = await _api.getExtractWorkerForeignCitizenInVn(request);
          break;
        default:
          response = await _api.getExtractWorkerVnCitizen(request);
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
  Future<Either<String, DetailWorkerResponse>> getExtractDetailWorkers(
      int idWorker, TypeExtractWorker type) async {
    try {
      ApiResponse<DetailWorkerResponse> response;

      switch (type) {
        case TypeExtractWorker.vnInForeign:
          response = await _api.getExtractDetailWorkerVnCitizen(idWorker);
          break;
        case TypeExtractWorker.inBusiness:
          response = await _api.getExtractDetailWorkerInBusiness(idWorker);
          break;
        case TypeExtractWorker.foreignInVn:
          response =
              await _api.getExtractDetailWorkerForeignCitizenInVn(idWorker);
          break;
        case TypeExtractWorker.manageInBusiness:
          response = await _api.getDetailManageWorker(idWorker);
          break;
        default:
          response = await _api.getExtractDetailWorkerVnCitizen(idWorker);
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
  Future<Either<String, ListDataResponse<WorkerResponse>>> getManageWorkers(
      {required TypeExtractWorker type, required WorkerRequest request}) async {
    try {
      late final ApiResponse<ListDataResponse<WorkerResponse>> response;
      switch (type) {
        case TypeExtractWorker.manageInBusiness:
          response = await _api.getManageWorkers(request);
          break;
        case TypeExtractWorker.manageForeignInVn:
          response = await _api.getManageWorkersForeignInVN(request);
          break;
        case TypeExtractWorker.manageVnInForeign:
          response = await _api.getManageWorkersVnInForeign(request);
          break;
        default:
          response = await _api.getManageWorkers(request);
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
  Future<Either<String, bool>> deleteManageWorker(int idWorker) async {
    try {
      final response = await _api.deleteManageWorker(idWorker);
      if (response.status) {
        return Right(response.status);
      }
      return Left(response.message);
    } catch (e) {
      return Left(e.toString());
    }
  }

  @override
  Future<Either<String, DetailWorkerResponse>> getManageDetailWorkers(
      int idWorker) async {
    try {
      final response = await _api.getDetailManageWorker(idWorker);
      if (response.status && response.data != null) {
        return Right(response.data!);
      }
      return Left(response.message);
    } catch (e) {
      return Left(e.toString());
    }
  }
}
