import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';

part 'register_request.g.dart';

@JsonSerializable()
class RegisterRequest {
  @JsonKey(name: "FullName")
  final String? fullName;
  @JsonKey(name: "UserName")
  final String? useName;
  @JsonKey(name: "Email")
  final String? email;
  @JsonKey(name: "Password")
  final String? password;
  @JsonKey(name: "RePassword")
  final String? confirmPass;
  @JsonKey(name: "PhoneNumber")
  final String? phoneNumber;
  @JsonKey(name: "Gender")
  final int? gender;
  @JsonKey(name: "Address")
  final String? address;
  @JsonKey(name: "BirthDay")
  final DateTime? dateOfBirth;
  @JsonKey(name: "TypeAccount")
  final String? typeAccount;

  const RegisterRequest(
      {this.email = '',
      this.gender = 0,
      this.address = '',
      this.fullName = '',
      this.confirmPass = '',
      this.dateOfBirth,
      this.password = '',
      this.phoneNumber = '',
      this.typeAccount = '',
      this.useName = ''});

  RegisterRequest copyWith(
      {String? fullName,
      String? useName,
      String? email,
      String? password,
      String? confirmPass,
      String? phoneNumber,
      int? gender,
      String? typeAccount,
      String? address,
      DateTime? dateOfBirth}) {
    return RegisterRequest(
      address: address ?? this.address,
      gender: gender ?? this.gender,
      fullName: fullName ?? this.fullName,
      email: email ?? this.email,
      typeAccount: typeAccount ?? this.typeAccount,
      confirmPass: confirmPass ?? this.confirmPass,
      password: password ?? this.password,
      dateOfBirth: dateOfBirth ?? this.dateOfBirth,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      useName: useName ?? this.useName,
    );
  }

  factory RegisterRequest.fromJson(Map<String, dynamic> json) =>
      _$RegisterRequestFromJson(json);

  Map<String, dynamic> toJson() => _$RegisterRequestToJson(this);
}
