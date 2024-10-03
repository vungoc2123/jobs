import 'package:json_annotation/json_annotation.dart';

part 'household_response.g.dart';

@JsonSerializable()
class HouseholdResponse {
  @JsonKey(name: "Id")
  final int id;
  @JsonKey(name: "SoHoKhau")
  final String? householdRegistrationBook;
  @JsonKey(name: "HoVaTen_ChuHo")
  final String? fullNameOfHouseholdHead;
  @JsonKey(name: "SoCCCD_ChuHo")
  final String? idNumberOfHouseholdHead;
  @JsonKey(name: "KhuVuc")
  final String? area;
  @JsonKey(name: "TenTinh")
  final String? provinceName;
  @JsonKey(name: "TenHuyen")
  final String? districtName;
  @JsonKey(name: "TenXa")
  final String? communeName;
  @JsonKey(name: "DiaChiChiTiet")
  final String? detailAddress;
  @JsonKey(name: "SatNhap")
  final String? merged;
  @JsonKey(name: "TachHo")
  final String? splitHousehold;

  const HouseholdResponse(
      {this.householdRegistrationBook,
      this.area,
      this.communeName,
      this.districtName,
      this.fullNameOfHouseholdHead,
      this.idNumberOfHouseholdHead,
      this.merged,
      this.provinceName,
      this.splitHousehold,
      this.detailAddress,
      this.id=-1});

  factory HouseholdResponse.fromJson(Map<String, dynamic> json) =>
      _$HouseholdResponseFromJson(json);

  Map<String, dynamic> toJson() => _$HouseholdResponseToJson(this);
}
