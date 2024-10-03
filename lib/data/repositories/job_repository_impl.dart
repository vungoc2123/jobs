import 'package:easy_localization/easy_localization.dart';
import 'package:either_dart/src/either.dart';
import 'package:phu_tho_mobile/application/enums/type_action.dart';
import 'package:phu_tho_mobile/data/data_sources/api/api_client.dart';
import 'package:phu_tho_mobile/data/data_sources/api/api_response.dart';
import 'package:phu_tho_mobile/di.dart';
import 'package:phu_tho_mobile/domain/models/request/job_request/job_request.dart';
import 'package:phu_tho_mobile/domain/models/response/job/job_response.dart';
import 'package:phu_tho_mobile/domain/repositories/job_repository.dart';

class JobRepositoryImpl implements JobRepository {
  final api = getIt.get<ApiClient>();

  @override
  Future<Either<String, ListDataResponse<JobResponse>>> getJobs(
      JobRequest request, TypeAction type) async {
    try {
      ApiResponse<ListDataResponse<JobResponse>> response;
      switch (type) {
        case TypeAction.extract:
          response = await api.getJobs(request);
          break;
        case TypeAction.manage:
          response = await api.getManageJobs(request);
          break;
        default:
          response = await api.getJobs(request);
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
  Future<Either<String, String>> deleteJob(int id) async {
    try {
      final response = await api.deleteJob(id);
      if (response.status) {
        return Right(response.message);
      }
      return Left(response.message);
    } catch (e) {
      return Left(e.toString());
    }
  }

  @override
  Future<Either<String, String>> applyJob(int id) async {
    try {
      final response = await api.applyJob(id);
      if (response.status) {
        return Right(response.message);
      }
      return Left(response.message);
    } catch (e) {
      return Left(e.toString());
    }
  }
}
