import 'package:either_dart/either.dart';
import 'package:phu_tho_mobile/application/enums/type_action.dart';
import 'package:phu_tho_mobile/data/data_sources/api/api_response.dart';
import 'package:phu_tho_mobile/domain/models/request/job_request/job_request.dart';
import 'package:phu_tho_mobile/domain/models/response/job/job_response.dart';

abstract class JobRepository {
  Future<Either<String, ListDataResponse<JobResponse>>> getJobs(
      JobRequest request,TypeAction type);

  Future<Either<String,String>> deleteJob(int id);

  Future<Either<String,String>> applyJob(int id);
}
