import 'package:either_dart/either.dart';
import 'package:phu_tho_mobile/data/data_sources/api/api_client.dart';
import 'package:phu_tho_mobile/data/data_sources/api/api_response.dart';
import 'package:phu_tho_mobile/di.dart';
import 'package:phu_tho_mobile/domain/models/request/edit_information/edit_information_request.dart';
import 'package:phu_tho_mobile/domain/models/response/user/user_profile_response.dart';
import 'package:phu_tho_mobile/domain/repositories/user_repository.dart';

class UserRepositoryImpl implements UserRepository {
  final _api = getIt.get<ApiClient>();

  @override
  Future<Either<String, ApiResponse<UserProfileResponse>>> getUserProfile(
      int accountId) async {
    try {
      final response = await _api.getUserProfile(accountId);
      if (response.status && response.data != null) {
        return Right(response);
      }
      return Left(response.message);
    } catch (e) {
      return Left(e.toString());
    }
  }

  @override
  Future<Either<String, String>> updateInformationUser(
      EditInformationRequest request) async {
    try {
      final response = await _api.updateInformationUser(request);
      if (response.status) {
        return Right(response.message);
      }
      return Left(response.message);
    } catch (e) {
      return Left(e.toString());
    }
  }

  @override
  Future<Either<String, String>> deleteAccount(int id) async {
    try {
      final response = await _api.deleteAccount(id);
      if (response.status) {
        return Right(response.message);
      }
      return Left(response.message);
    } catch (e) {
      return Left(e.toString());
    }
  }
}
