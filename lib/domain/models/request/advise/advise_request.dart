import 'package:json_annotation/json_annotation.dart';
import 'package:phu_tho_mobile/application/constants/app_page.dart';

part 'advise_request.g.dart';

@JsonSerializable(includeIfNull: false)
class AdviseRequest {
  @JsonKey(name: "tenDoanhNghiepFilter")
  final String? nameBusiness;
  @JsonKey(name: "khuCongNghiepFilter")
  final String? industrialPark;
  @JsonKey(name: "maSoThueFilter")
  final String? taxCode;
  final String? hotlineFilter;
  @JsonKey(name: "diaChiFilter")
  final String? location;

  final int pageIndex;
  final int pageSize;

  const AdviseRequest(
      {this.nameBusiness,
      this.hotlineFilter,
      this.industrialPark,
      this.location,
      this.taxCode,
      this.pageIndex = 1,
      this.pageSize = AppPage.pageSize});

  AdviseRequest copyWith(
      {int? pageSize,
      int? pageIndex,
      String? nameBusiness,
      String? industrialPark,
      String? taxCode,
      String? hotlineFilter,
      String? location}) {
    return AdviseRequest(
        pageSize: pageSize ?? this.pageSize,
        pageIndex: pageIndex ?? this.pageIndex,
        hotlineFilter: hotlineFilter ?? this.hotlineFilter,
        industrialPark: industrialPark ?? this.industrialPark,
        location: location ?? this.location,
        nameBusiness: nameBusiness ?? this.nameBusiness,
        taxCode: taxCode ?? this.taxCode);
  }

  factory AdviseRequest.fromJson(Map<String, dynamic> json) =>
      _$AdviseRequestFromJson(json);

  Map<String, dynamic> toJson() =>
      _$AdviseRequestToJson(this);
}
