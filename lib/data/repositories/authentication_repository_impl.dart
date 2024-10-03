import 'package:either_dart/either.dart';
import 'package:phu_tho_mobile/data/data_sources/api/api_client.dart';
import 'package:phu_tho_mobile/data/data_sources/api/api_response.dart';
import 'package:phu_tho_mobile/data/data_sources/storage/shared_preferences/shared_preferences_helper.dart';
import 'package:phu_tho_mobile/di.dart';
import 'package:phu_tho_mobile/domain/models/request/change_password/change_password_request.dart';
import 'package:phu_tho_mobile/domain/models/request/forgot_password/forgot_password_request.dart';
import 'package:phu_tho_mobile/domain/models/request/login_request/login_request.dart';
import 'package:phu_tho_mobile/domain/models/request/register_request/register_request.dart';
import 'package:phu_tho_mobile/domain/models/request/validate_account_by_qr/validate_account_by_qr_request.dart';
import 'package:phu_tho_mobile/domain/models/response/login/login_response.dart';
import 'package:phu_tho_mobile/domain/repositories/authentication_repository.dart';

class AuthenticationRepositoryImpl implements AuthenticationRepository {
  final _api = getIt.get<ApiClient>();
  final _sharedPreference = getIt.get<SharedPreferencesHelper>();

  @override
  Future<Either<String, ApiResponse<LoginResponse>>> login(
      LoginRequest loginRequest) async {
    try {
      final response = await _api.login(loginRequest);
      if (response.status && response.data != null) {
        return Right(response);
      }
      return Left(response.message);
    } catch (e) {
      return Left(e.toString());
    }
  }

  @override
  Future<void> logout() async {
    await _sharedPreference.removeLoggedInfo();
  }

  @override
  Future<Either<String, String>> forgotPassword(
      ForgotPasswordRequest request) async {
    try {
      final response = await _api.forgotPassword(request);
      if (response.status == true) {
        return Right(response.message);
      }
      return Left(response.message);
    } catch (e) {
      return Left(e.toString());
    }
  }

  @override
  Future<Either<String, String>> changePassword(ChangePasswordRequest request) async {
    try {
      final response = await _api.changePassword(request);
      if (response.status == true) {
        return Right(response.message);
      }
      return Left(response.message);
    } catch (e) {
      return Left(e.toString());
    }
  }

  @override
  Future<Either<String,String>> registerAccount(RegisterRequest request) async {
    try {
      final response = await _api.createAccount(request);
      if (response.status == true) {
        return Right(response.message);
      }
      return Left(response.message);
    } catch (e) {
      return Left(e.toString());
    }
  }

  @override
  Future<Either<String,String>> validateAccountByQr(ValidateAccountByQrRequest request) async {
    try {
      final response = await _api.validateAccountByQr(request);
      if (response.status) {
        return Right(response.message);
      }
      return Left(response.message);
    } catch (e) {
      return Left(e.toString());
    }
  }
}
