import 'package:json_annotation/json_annotation.dart';

part 'edit_information_request.g.dart';

@JsonSerializable()
class EditInformationRequest {
  @JsonKey(name: "Id")
  final int id;
  @JsonKey(name: "Email")
  final String email;
  @JsonKey(name: "PhoneNumber")
  final String phoneNumber;
  @JsonKey(name: "BirthDay")
  final String birthDay;
  @JsonKey(name: "Gender")
  final int gender;
  @JsonKey(name: "Address")
  final String address;
  @JsonKey(name: "FullName")
  final String fullName;

  const EditInformationRequest(
      {this.id = -1,
      this.gender = 0,
      this.address = '',
      this.email = '',
      this.phoneNumber = '',
      this.birthDay = '',
      this.fullName = ''});

  EditInformationRequest copyWith(
      {int? id,
      String? email,
      String? phoneNumber,
      String? birthDay,
      int? gender,
      String? address,
      String? fullName}) {
    return EditInformationRequest(
        id: id ?? this.id,
        gender: gender ?? this.gender,
        phoneNumber: phoneNumber ?? this.phoneNumber,
        email: email ?? this.email,
        address: address ?? this.address,
        birthDay: birthDay ?? this.birthDay,
        fullName: fullName ?? this.fullName);
  }

  factory EditInformationRequest.fromJson(Map<String, dynamic> json) =>
      _$EditInformationRequestFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$EditInformationRequestToJson(this);
}
