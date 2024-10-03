import 'package:json_annotation/json_annotation.dart';

part "forgot_password_request.g.dart";

@JsonSerializable()
class ForgotPasswordRequest {
  @JsonKey(name: "Username")
  final String username;
  @JsonKey(name: "Email")
  final String email;

  const ForgotPasswordRequest({this.username = '', this.email = ''});

  ForgotPasswordRequest copyWith({String? username, String? email}) {
    return ForgotPasswordRequest(
        username: username ?? this.username, email: email ?? this.email);
  }

  factory ForgotPasswordRequest.fromJson(Map<String, dynamic> json) =>
      _$ForgotPasswordRequestFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$ForgotPasswordRequestToJson(this);
}
