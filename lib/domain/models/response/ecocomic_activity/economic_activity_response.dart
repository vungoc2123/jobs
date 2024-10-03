import 'package:json_annotation/json_annotation.dart';

part 'economic_activity_response.g.dart';

@JsonSerializable()
class EconomicActivityResponse {
  @JsonKey(name: "Id")
  final int id;
  @JsonKey(name: "ThoiGianBatDau")
  final String timeStart;
  @JsonKey(name: "ThoiGianKetThuc")
  final String timeEnd;
  @JsonKey(name: "NoiLamViec")
  final String location;
  @JsonKey(name: "ViTriCongViec")
  final String position;
  @JsonKey(name: "MoTaCongViec")
  final String description;
  @JsonKey(name: "TuLam_LamCongTxt")
  final String selfEmployedAndEmployed;
  @JsonKey(name: "LoaiHinhKinhTeTxt")
  final String typeEconomic;
  @JsonKey(name: "IdThanhVien")
  final int idMember;
  @JsonKey(name: "TenNguoiHoatDong")
  final String namePerson;

  const EconomicActivityResponse(
      {this.id = 0,
      this.timeStart = '',
      this.timeEnd = '',
      this.location = '',
      this.position = '',
      this.description = '',
      this.selfEmployedAndEmployed = '',
      this.typeEconomic = '',
      this.idMember = 0,
      this.namePerson = ''});

  factory EconomicActivityResponse.fromJson(Map<String, dynamic> json) =>
      _$EconomicActivityResponseFromJson(json);

  Map<String, dynamic> toJson() => _$EconomicActivityResponseToJson(this);
}
