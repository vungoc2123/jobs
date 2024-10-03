import 'package:json_annotation/json_annotation.dart';
import 'package:phu_tho_mobile/domain/models/response/account/account_response.dart';

part 'login_response.g.dart';

@JsonSerializable()
class LoginResponse {
  @JsonKey(name: "TimeoutToken")
  final String timeoutToken;
  @JsonKey(name: 'Token')
  final String token;
  @JsonKey(name: "AccountInfo")
  final AccountResponse accountInfo;

  const LoginResponse(
      {this.accountInfo = const AccountResponse(),
      this.timeoutToken = '',
      this.token = ''});

  factory LoginResponse.fromJson(Map<String, dynamic> json) => _$LoginResponseFromJson(json);

  Map<String, dynamic> toJson() => _$LoginResponseToJson(this);
}
