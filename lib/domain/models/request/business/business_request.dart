import 'package:json_annotation/json_annotation.dart';
import 'package:phu_tho_mobile/application/constants/app_page.dart';
import 'package:phu_tho_mobile/domain/models/common/item_filter.dart';
import 'package:phu_tho_mobile/domain/models/request/base_request/base_request.dart';

part 'business_request.g.dart';

@JsonSerializable(includeIfNull: false)
class BusinessRequest extends BaseRequest {
  @JsonKey(name: "TenDoanhNghiep")
  final String? nameBusiness;
  @JsonKey(name: "MaSoThue")
  final String? taxCode;
  @JsonKey(name: "DiaChi")
  final String? address;
  @JsonKey(name: "TinhTrangHoatDong")
  final String? status;
  @JsonKey(name: "idKCN")
  final int? id;

  const BusinessRequest(
      {this.nameBusiness,
      this.status,
      this.address,
      this.taxCode,
      this.id,
      super.pageIndex,
      super.pageSize});

  @override
  BusinessRequest copyWith(
      {String? nameBusiness,
      int? pageSize,
      int? pageIndex,
      String? taxCode,
      String? address,
      int? id,
      String? status}) {
    return BusinessRequest(
        nameBusiness: nameBusiness ?? this.nameBusiness,
        status: status ?? this.status,
        address: address ?? this.address,
        taxCode: taxCode ?? this.taxCode,
        pageSize: pageSize ?? this.pageSize,
        id: id ?? this.id,
        pageIndex: pageIndex ?? this.pageIndex);
  }

  factory BusinessRequest.fromJson(Map<String, dynamic> json) =>
      _$BusinessRequestFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$BusinessRequestToJson(this);
}
