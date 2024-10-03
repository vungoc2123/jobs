import 'package:json_annotation/json_annotation.dart';

part 'login_request.g.dart';

@JsonSerializable()
class LoginRequest {
  @JsonKey(name: "UserName")
  final String userName;
  @JsonKey(name: "Password")
  final String password;
  @JsonKey(name: "RememberMe")
  final bool rememberMe;

  const LoginRequest(
      {this.userName = '', this.password = '', this.rememberMe = false});

  LoginRequest copyWith(
      {String? userName, String? password, bool? rememberMe}) {
    return LoginRequest(
        userName: userName ?? this.userName,
        password: password ?? this.password,
        rememberMe: rememberMe ?? this.rememberMe);
  }

  factory LoginRequest.fromJson(Map<String, dynamic> json) =>
      _$LoginRequestFromJson(json);

  Map<String, dynamic> toJson() => _$LoginRequestToJson(this);
}
