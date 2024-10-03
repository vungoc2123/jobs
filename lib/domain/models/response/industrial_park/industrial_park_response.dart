import 'package:json_annotation/json_annotation.dart';

part 'industrial_park_response.g.dart';

@JsonSerializable()
class IndustrialParkResponse {
  @JsonKey(name: "Id")
  final int id;
  @JsonKey(name: "TenKhuCN")
  final String name;
  @JsonKey(name: "DiaDiem")
  final String location;
  @JsonKey(name: "TenHuyen")
  final String nameDistrict;
  @JsonKey(name: "TenXa")
  final String nameCommune;
  @JsonKey(name: "TrangThaiName")
  final String status;

  const IndustrialParkResponse(
      {this.id = 0,
      this.name = '',
      this.location = '',
      this.nameDistrict = '',
      this.nameCommune = '',
      this.status = ''});

  factory IndustrialParkResponse.fromJson(Map<String, dynamic> json) =>
      _$IndustrialParkResponseFromJson(json);

  Map<String, dynamic> toJson() => _$IndustrialParkResponseToJson(this);
}
