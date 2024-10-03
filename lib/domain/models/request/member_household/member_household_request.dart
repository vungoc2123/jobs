import 'package:json_annotation/json_annotation.dart';
import 'package:phu_tho_mobile/domain/models/request/base_request/base_request.dart';

import '../../../../application/constants/app_page.dart';

part 'member_household_request.g.dart';

@JsonSerializable(includeIfNull: false)
class MemberHouseholdRequest extends BaseRequest {
  @JsonKey(name: "IdHoGiaDinhFilter")
  final int? idHousehold;
  @JsonKey(name: "hoVaTenFilter")
  final String? fullName;
  @JsonKey(name: "gioiTinhFilter")
  final String? gender;
  @JsonKey(name: "soCCCDFilter")
  final String? idCard;
  @JsonKey(name: "danTocFilter")
  final String? ethnicity;
  @JsonKey(name: "quanHeChuHoFilter")
  final String? relationShipWith;
  @JsonKey(name: "soBHYTFilter")
  final String? healthInsurance;
  @JsonKey(name: "soBHXHFilter")
  final String? socialInsurance;
  @JsonKey(name: "diaChiChiTietFilter")
  final String? detailAddress;
  @JsonKey(name: "huyenFilter")
  final String? districtFilter;
  @JsonKey(name: "xaFilter")
  final String? communeFilter;

  const MemberHouseholdRequest(
      {this.idCard,
      this.socialInsurance,
      this.healthInsurance,
      this.ethnicity,
      this.fullName,
      this.gender,
      this.idHousehold,
      this.relationShipWith,
      this.detailAddress,
      this.communeFilter,
      this.districtFilter,
      super.pageIndex,
      super.pageSize});

  @override
  MemberHouseholdRequest copyWith(
      {String? idCard,
      String? fullName,
      String? gender,
      int? idHousehold,
      String? socialInsurance,
      String? healthInsurance,
      String? relationShipWith,
      String? ethnicity,
      String? detailAddress,
      String? districtFilter,
      String? communeFilter,
      int? pageSize,
      int? pageIndex}) {
    return MemberHouseholdRequest(
        pageIndex: pageIndex ?? this.pageIndex,
        pageSize: pageSize ?? this.pageSize,
        fullName: fullName ?? this.fullName,
        ethnicity: ethnicity ?? this.ethnicity,
        gender: gender ?? this.gender,
        healthInsurance: healthInsurance ?? this.healthInsurance,
        idCard: idCard ?? this.idCard,
        idHousehold: idHousehold ?? this.idHousehold,
        relationShipWith: relationShipWith ?? this.relationShipWith,
        socialInsurance: socialInsurance ?? this.socialInsurance,
        detailAddress: detailAddress ?? this.detailAddress,
        communeFilter: communeFilter ?? this.communeFilter,
        districtFilter: districtFilter ?? this.districtFilter);
  }

  factory MemberHouseholdRequest.fromJson(Map<String, dynamic> json) =>
      _$MemberHouseholdRequestFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$MemberHouseholdRequestToJson(this);
}
