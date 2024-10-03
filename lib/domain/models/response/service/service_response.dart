import 'package:json_annotation/json_annotation.dart';

part 'service_response.g.dart';

@JsonSerializable()
class ServiceResponse {
  @JsonKey(name: "NguoiNop")
  final String name;

  @JsonKey(name: "TenPhiDichVu")
  final String nameService;

  @JsonKey(name: "SoTien")
  final double cost;

  @JsonKey(name: "GhiChu")
  final String note;

  const ServiceResponse({this.name='', this.note = '', this.cost=0.0, this.nameService ='',});

  factory ServiceResponse.fromJson(Map<String,dynamic> json) => _$ServiceResponseFromJson(json);
  Map<String,dynamic> toJson() => _$ServiceResponseToJson(this);
}