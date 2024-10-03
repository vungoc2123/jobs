import 'package:json_annotation/json_annotation.dart';
part 'account_response.g.dart';

@JsonSerializable()
class AccountResponse {
  @JsonKey(name: 'UserName')
  final String userName;
  @JsonKey(name: 'Email')
  final String mail;
  @JsonKey(name: 'PhoneNumber')
  final String phoneNumber;
  @JsonKey(name: 'BirthDay')
  final String birthDay;
  @JsonKey(name: 'Gender')
  final int gender;
  @JsonKey(name: 'Address')
  final String address;
  @JsonKey(name: 'FullName')
  final String fullName;
  @JsonKey(name: 'Id')
  final int id;

  const AccountResponse(
      {this.userName = '',
      this.id = -1,
      this.fullName = '',
      this.address = '',
      this.birthDay = '',
      this.gender = 0,
      this.mail = '',
      this.phoneNumber = ''});

  factory AccountResponse.fromJson(Map<String, dynamic> json) => _$AccountResponseFromJson(json);

  Map<String, dynamic> toJson() => _$AccountResponseToJson(this);
}
