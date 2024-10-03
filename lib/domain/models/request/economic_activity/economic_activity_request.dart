import 'package:json_annotation/json_annotation.dart';
import 'package:phu_tho_mobile/application/constants/app_page.dart';
import 'package:phu_tho_mobile/domain/models/request/base_request/base_request.dart';

part 'economic_activity_request.g.dart';

@JsonSerializable(includeIfNull: false)
class EconomicActivityRequest extends BaseRequest {
  @JsonKey(name: 'NamBatDauFilter')
  final String? timeStart;
  @JsonKey(name: 'NamKetThucFilter')
  final String? timeEnd;
  @JsonKey(name: 'TenNguoiHoatDongFilter')
  final String? namePerson;
  @JsonKey(name: 'NoiLamViecFilter')
  final String? location;
  @JsonKey(name: 'ViTriCongViecFilter')
  final String? position;
  @JsonKey(name: 'loaiHinhKinhTeFilter')
  final String? typeEconomic;
  @JsonKey(name: 'tuLam_LamCongFilter')
  final String? typeWork;

  const EconomicActivityRequest(
      {super.pageIndex,
      super.pageSize,
      this.timeStart,
      this.timeEnd,
      this.namePerson,
      this.location,
      this.typeEconomic,
      this.typeWork,
      this.position});

  @override
  EconomicActivityRequest copyWith(
      {int? pageIndex,
      int? pageSize,
      String? timeStart,
      String? timeEnd,
      String? namePerson,
      String? location,
      String? typeEconomic,
      String? typeWork,
      String? position}) {
    return EconomicActivityRequest(
        timeStart: timeStart ?? this.timeStart,
        timeEnd: timeEnd ?? this.timeEnd,
        pageIndex: pageIndex ?? this.pageIndex,
        pageSize: pageSize ?? this.pageSize,
        location: location ?? this.location,
        namePerson: namePerson ?? this.namePerson,
        typeEconomic: typeEconomic ?? this.typeEconomic,
        typeWork: typeWork ?? this.typeWork,
        position: position ?? this.position);
  }

  factory EconomicActivityRequest.fromJson(Map<String, dynamic> json) =>
      _$EconomicActivityRequestFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$EconomicActivityRequestToJson(this);
}
