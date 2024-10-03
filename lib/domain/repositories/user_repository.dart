import 'package:either_dart/either.dart';
import 'package:phu_tho_mobile/data/data_sources/api/api_response.dart';
import 'package:phu_tho_mobile/domain/models/request/edit_information/edit_information_request.dart';
import 'package:phu_tho_mobile/domain/models/response/user/user_profile_response.dart';

abstract class UserRepository {
  Future<Either<String, ApiResponse<UserProfileResponse>>> getUserProfile(
      int accountId);

  Future<Either<String, String>> updateInformationUser(
      EditInformationRequest request);

  Future<Either<String,String>> deleteAccount(int id);
}
