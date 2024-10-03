import 'package:json_annotation/json_annotation.dart';

part 'change_password_request.g.dart';

@JsonSerializable()
class ChangePasswordRequest {
  @JsonKey(name: "OldPassword")
  final String oldPassword;
  @JsonKey(name: "NewPassword")
  final String newPassword;
  @JsonKey(name: "ConfirmPassword")
  final String confirmPassword;

  const ChangePasswordRequest(
      {this.oldPassword = '',
      this.newPassword = '',
      this.confirmPassword = ''});

  ChangePasswordRequest copyWith(
      {String? oldPassword, String? newPassword, String? confirmPassword}) {
    return ChangePasswordRequest(
        oldPassword: oldPassword ?? this.oldPassword,
        confirmPassword: confirmPassword ?? this.confirmPassword,
        newPassword: newPassword ?? this.newPassword);
  }

  factory ChangePasswordRequest.fromJson(Map<String, dynamic> json) =>
      _$ChangePasswordRequestFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$ChangePasswordRequestToJson(this);
}
