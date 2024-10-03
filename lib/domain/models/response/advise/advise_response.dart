import 'package:json_annotation/json_annotation.dart';

part 'advise_response.g.dart';

@JsonSerializable()
class AdviseResponse {
  @JsonKey(name: "TenDoanhNghiep")
  final String nameBusiness;
  @JsonKey(name: "MaSoThue")
  final String taxCode;
  @JsonKey(name: "Hotline")
  final String hotline;
  @JsonKey(name: "DiaChi")
  final String address;
  @JsonKey(name: "TenKhuCongNghiep")
  final String nameIndustrialPark;

  const AdviseResponse({this.taxCode = '',
    this.nameBusiness = '',
    this.address = '',
    this.hotline = '',
    this.nameIndustrialPark = ''});

  factory AdviseResponse.fromJson(Map<String,dynamic> json) => _$AdviseResponseFromJson(json);
  Map<String,dynamic> toJson() => _$AdviseResponseToJson(this);
}