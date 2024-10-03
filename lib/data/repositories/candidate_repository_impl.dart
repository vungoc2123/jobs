import 'package:either_dart/either.dart';
import 'package:phu_tho_mobile/data/data_sources/api/api_client.dart';
import 'package:phu_tho_mobile/data/data_sources/api/api_response.dart';
import 'package:phu_tho_mobile/di.dart';
import 'package:phu_tho_mobile/domain/models/request/candidate_profile_request/candidate_profile_request.dart';
import 'package:phu_tho_mobile/domain/models/response/cadidate/candidate_response.dart';
import 'package:phu_tho_mobile/domain/repositories/candidate_repository.dart';

class CandidateRepositoryImpl implements CandidateRepository {
  final api = getIt.get<ApiClient>();

  @override
  Future<Either<String, ListDataResponse<CandidateResponse>>> getAllCandidate(CandidateProFileRequest request) async{
    try{
      final response = await api.getCandidateProfile(request);
      if(response.status && response.data != null){
        return Right(response.data!);
      }
      return Left(response.message);
    }catch (e){
      return Left(e.toString());
    }
  }
}
