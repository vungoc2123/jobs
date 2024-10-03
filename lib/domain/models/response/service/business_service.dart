import 'package:json_annotation/json_annotation.dart';
import 'package:phu_tho_mobile/domain/models/response/service/service_response.dart';

part 'business_service.g.dart';

@JsonSerializable()
class BusinessServiceResponse {
  @JsonKey(name: "TenDoanhNghiep")
  final String nameBusiness;
  @JsonKey(name: "MaSoThue")
  final String taxCode;
  @JsonKey(name: "DiaChi")
  final String address;
  @JsonKey(name: "TuVan_PhiDV")
  final List<ServiceResponse>? listServiceFee;

  const BusinessServiceResponse({
    this.nameBusiness = '',
    this.taxCode = '',
    this.address = '',
    this.listServiceFee = const [],
  });

  factory BusinessServiceResponse.fromJson(Map<String, dynamic> json) =>
      _$BusinessServiceResponseFromJson(json);

  Map<String, dynamic> toJson() => _$BusinessServiceResponseToJson(this);
}
