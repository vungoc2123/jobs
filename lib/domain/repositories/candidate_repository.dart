import 'package:either_dart/either.dart';
import 'package:phu_tho_mobile/data/data_sources/api/api_response.dart';
import 'package:phu_tho_mobile/domain/models/request/candidate_profile_request/candidate_profile_request.dart';
import 'package:phu_tho_mobile/domain/models/response/cadidate/candidate_response.dart';

abstract class CandidateRepository {
  Future<Either<String, ListDataResponse<CandidateResponse>>> getAllCandidate(
      CandidateProFileRequest request);
}
