import 'package:json_annotation/json_annotation.dart';
import 'package:phu_tho_mobile/application/constants/app_page.dart';
import 'package:phu_tho_mobile/domain/models/request/base_request/base_request.dart';

part 'candidate_profile_request.g.dart';

@JsonSerializable(includeIfNull: false)
class CandidateProFileRequest extends BaseRequest {
  final String? titleFilter;

  @JsonKey(name: "viTriTuyenDungFilter")
  final String? positioned;
  @JsonKey(name: "maTinhFilter")
  final String? province;
  @JsonKey(name: "maHuyenFilter")
  final String? district;
  @JsonKey(name: "nganhNgheFilter")
  final String? jobName;
  @JsonKey(name: "mucLuongDeXuatFilter")
  final String? salaryFilter;
  @JsonKey(name: "gioiTinhFilter")
  final int? gender;
  @JsonKey(name: "trinhDoFilter")
  final String? level;
  @JsonKey(name: "soNamEXPFilter")
  final String? exp;

  const CandidateProFileRequest(
      {this.exp,
      this.titleFilter,
      this.jobName,
      this.level,
      this.salaryFilter,
      this.district,
      this.gender,
      this.positioned,
      this.province,
      super.pageIndex,
      super.pageSize});

  CandidateProFileRequest copyWith(
      {int? pageIndex,
      String? titleFilter,
      int? pageSize,
      String? salaryFilter,
      String? positioned,
      String? province,
      String? district,
      String? jobName,
      int? gender,
      String? level,
      String? exp}) {
    return CandidateProFileRequest(
        pageIndex: pageIndex ?? this.pageIndex,
        pageSize: pageSize ?? this.pageSize,
        salaryFilter: salaryFilter ?? this.salaryFilter,
        titleFilter: titleFilter ?? this.titleFilter,
        gender: gender ?? this.gender,
        level: level ?? this.level,
        exp: exp ?? this.exp,
        district: district ?? this.district,
        jobName: jobName ?? this.jobName,
        positioned: positioned ?? this.positioned,
        province: province ?? this.province);
  }

  factory CandidateProFileRequest.fromJson(Map<String, dynamic> json) =>
      _$CandidateProFileRequestFromJson(json);

  Map<String, dynamic> toJson() => _$CandidateProFileRequestToJson(this);
}
