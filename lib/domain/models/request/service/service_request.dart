import 'package:json_annotation/json_annotation.dart';
import 'package:phu_tho_mobile/domain/models/request/base_request/base_request.dart';

import '../../../../application/constants/app_page.dart';

part 'service_request.g.dart';

@JsonSerializable()
class ServiceRequest extends BaseRequest {
  @JsonKey(name: "tenDoanhNghiepFilter")
  final String? nameBusiness;
  @JsonKey(name: "maSoThueFilter")
  final String? taxCode;
  @JsonKey(name: "diaChiFilter")
  final String? address;

  const ServiceRequest(
      {this.nameBusiness,
      this.taxCode,
      this.address,
      super.pageIndex,
      super.pageSize});

  @override
  ServiceRequest copyWith(
      {String? nameBusiness, String? taxCode, String? address, int? pageIndex, int? pageSize}) {
    return ServiceRequest(
        pageIndex: pageIndex ?? this.pageIndex,
        pageSize:  pageSize ?? this.pageSize,
        taxCode: taxCode ?? this.taxCode,
        nameBusiness: nameBusiness ?? this.nameBusiness,
        address: address ?? this.address);
  }

  factory ServiceRequest.fromJson(Map<String, dynamic> json) =>
      _$ServiceRequestFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$ServiceRequestToJson(this);
}
