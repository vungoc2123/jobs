import 'package:json_annotation/json_annotation.dart';
import 'package:phu_tho_mobile/application/extentions/string_extension.dart';
import 'package:phu_tho_mobile/domain/models/response/role_response/role_response.dart';

part 'user_profile_response.g.dart';

@JsonSerializable()
class UserProfileResponse {
  @JsonKey(name: 'FullName')
  final String fullName;

  @JsonKey(name: 'Avatar')
  final String avatar;

  @JsonKey(name: 'Email')
  final String email;

  @JsonKey(name: 'PhoneNumber')
  final String phoneNumber;

  @JsonKey(name: 'DepartmentName')
  final String departmentName;

  @JsonKey(name: 'Address')
  final String address;

  @JsonKey(name: 'BirthDay')
  final String birthDay;

  @JsonKey(name: 'UserName')
  final String username;

  @JsonKey(name: 'Gender')
  final int gender;

  @JsonKey(name: "ListRoles")
  final List<RoleResponse> listRoles;

  @JsonKey(name: "Id")
  final int id;

  @JsonKey(name: "IdChucVuName")
  final String idPositionName;

  @JsonKey(name: "GenderTxt")
  final String genderTxt;

  const UserProfileResponse(
      {this.fullName = '',
      this.avatar = '',
      this.email = '',
      this.phoneNumber = '',
      this.gender = -1,
      this.address = "",
      this.birthDay = '',
      this.departmentName = '',
      this.username = '',
      this.listRoles = const [],
      this.id = -1,
      this.idPositionName = '',
      this.genderTxt = ''});

  String get avatarUrl => avatar.toResourceUrl();

  String get rolesName {
    String result = '';
    for (var x in listRoles) {
      if (listRoles.first == x) {
        result += "${x.name}";
      } else {
        result += '\n${x.name}';
      }
    }
    return result;
  }

  factory UserProfileResponse.fromJson(Map<String, dynamic> json) =>
      _$UserProfileResponseFromJson(json);

  Map<String, dynamic> toJson() => _$UserProfileResponseToJson(this);
}
