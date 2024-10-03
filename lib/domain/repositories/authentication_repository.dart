import 'package:either_dart/either.dart';
import 'package:phu_tho_mobile/data/data_sources/api/api_response.dart';
import 'package:phu_tho_mobile/domain/models/request/change_password/change_password_request.dart';
import 'package:phu_tho_mobile/domain/models/request/forgot_password/forgot_password_request.dart';
import 'package:phu_tho_mobile/domain/models/request/login_request/login_request.dart';
import 'package:phu_tho_mobile/domain/models/request/register_request/register_request.dart';
import 'package:phu_tho_mobile/domain/models/request/validate_account_by_qr/validate_account_by_qr_request.dart';
import 'package:phu_tho_mobile/domain/models/response/login/login_response.dart';

abstract class AuthenticationRepository {
  Future<Either<String, ApiResponse<LoginResponse>>> login(LoginRequest loginRequest);

  Future<void> logout();

  Future<Either<String,String>> forgotPassword(ForgotPasswordRequest request);

  Future<Either<String,String>> changePassword(ChangePasswordRequest request);

  Future<Either<String,String>> registerAccount(RegisterRequest request);

  Future<Either<String,String>> validateAccountByQr(ValidateAccountByQrRequest request);
}