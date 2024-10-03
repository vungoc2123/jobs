import 'package:json_annotation/json_annotation.dart';

part 'job_request.g.dart';

@JsonSerializable(includeIfNull: false)
class JobRequest {
  final int pageIndex;
  final int pageSize;
  @JsonKey(name: "IsViecLamTotNhatFilter")
  final bool? isBestJob;
  @JsonKey(name: "IdFilter")
  final int? idFilter;
  @JsonKey(name: "TitleFilter")
  final String titleFilter;
  @JsonKey(name: "IdDoanhNghiepFilter")
  final int? idBusiness;

  @JsonKey(name: "ViTriTuyenDungFilter") // had
  final String? positioned;
  @JsonKey(name: "MaTinhFilter")
  final String? province;
  @JsonKey(name: "MaHuyenFilter")
  final String? district;
  @JsonKey(name: "NganhNgheFilter")
  final String? jobName;
  @JsonKey(name: "MucLuongDeXuatFilter")
  final String? salaryFilter;
  @JsonKey(name: "GioiTinhFilter")
  final int? gender;
  @JsonKey(name: "TrinhDoChuyenMonFilter") // had
  final String? level;
  @JsonKey(name: "YeuCauKinhNghiemFilter") // had
  final String? exp;
  @JsonKey(name: "IsDuyetFilter")
  final String? isApproved;
  @JsonKey(name: "IsHetHanFilter")
  final String? expire;

  const JobRequest(
      {this.pageIndex = 1,
      this.pageSize = 10,
      this.isBestJob,
      this.idFilter,
      this.titleFilter = '',
      this.idBusiness,
      this.gender,
      this.exp,
      this.level,
      this.salaryFilter,
      this.district,
      this.province,
      this.jobName,
      this.positioned,
        this.expire,
      this.isApproved});

  JobRequest copyWith(
      {int? pageIndex,
      int? pageSize,
      bool? isBestJob,
      int? idFilter,
      String? titleFilter,
      int? idBusiness,
      String? exp,
      String? level,
      int? gender,
      String? salaryFilter,
      String? jobName,
      String? district,
      String? province,
      String? isApproved,
        String? expire,
      String? positioned}) {
    return JobRequest(
      pageIndex: pageIndex ?? this.pageIndex,
      pageSize: pageSize ?? this.pageSize,
      isBestJob: isBestJob ?? this.isBestJob,
      idFilter: idFilter ?? this.idFilter,
      titleFilter: titleFilter ?? this.titleFilter,
      idBusiness: idBusiness ?? this.idBusiness,
      positioned: positioned ?? this.positioned,
      isApproved: isApproved ?? this.isApproved,
      gender: gender ?? this.gender,
      exp: exp ?? this.exp,
      level: level ?? this.level,
      salaryFilter: salaryFilter ?? this.salaryFilter,
      expire: expire ?? this.expire,
      district: district ?? this.district,
      province: province ?? this.province,
      jobName: jobName ?? this.jobName,
    );
  }

  factory JobRequest.fromJson(Map<String, dynamic> json) =>
      _$JobRequestFromJson(json);

  Map<String, dynamic> toJson() => _$JobRequestToJson(this);
}
