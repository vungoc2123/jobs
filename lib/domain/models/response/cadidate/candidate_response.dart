import 'package:json_annotation/json_annotation.dart';
import 'package:phu_tho_mobile/application/configs/env_configs.dart';

part 'candidate_response.g.dart';

@JsonSerializable()
class CandidateResponse {
  @JsonKey(name: "Title")
  final String title;
  @JsonKey(name: "NgayDang")
  final String datePost;
  @JsonKey(name: "NgayHetHan")
  final String dateExpiration;
  @JsonKey(name: "TrinhDoHocVan")
  final String educationLv;
  @JsonKey(name: "KinhNghiemLamViec")
  final String experience;
  @JsonKey(name: "MucTieuNgheNghiep")
  final String tagetJob;
  @JsonKey(name: "KyNang")
  final String skill;
  @JsonKey(name: "Slug")
  final String slug;
  @JsonKey(name: "LuotXem")
  final int views;
  @JsonKey(name: "NganhNgheText")
  final String jobName;
  @JsonKey(name: "NoiUngTuyenText")
  final String contentApply;
  @JsonKey(name: "SoNamEXPText")
  final String yearOfExperience;
  @JsonKey(name: "TrinhDoText")
  final String level;
  @JsonKey(name: "MucLuongDeXuatText")
  final String proposedSalary;
  @JsonKey(name: "TrangThaiText")
  final String statusText;
  @JsonKey(name: "ChucVuMongMuonText")
  final String desiredPosition;
  @JsonKey(name: "ChucVuHienTaiText")
  final String currenPosition;
  @JsonKey(name: "NhuCauLamViecText")
  final String jobNeedText;
  @JsonKey(name: "HoVaTen")
  final String fullName;
  @JsonKey(name: "GioiTinhTxt")
  final String sex;
  @JsonKey(name: "Avatar")
  final String avatar;
  @JsonKey(name: "NamSinh")
  final String? dateOfBirth;
  @JsonKey(name: "NgayDangTin")
  final String datePosting;

  String getAvatar() {
    return '${EnvConfigs.resourceUrl}/$avatar';
  }

  const CandidateResponse(
      {this.level = '',
      this.sex = '',
      this.views = 0,
      this.slug = '',
      this.datePosting = '',
      this.dateExpiration = '',
      this.avatar = '',
      this.title = '',
      this.fullName = '',
      this.contentApply = '',
      this.currenPosition = '',
      this.dateOfBirth,
      this.datePost = '',
      this.desiredPosition = '',
      this.educationLv = '',
      this.experience = '',
      this.jobName = '',
      this.jobNeedText = '',
      this.proposedSalary = '',
      this.skill = '',
      this.statusText = '',
      this.tagetJob = '',
      this.yearOfExperience = ''});

  factory CandidateResponse.fromJson(Map<String, dynamic> json) =>
      _$CandidateResponseFromJson(json);

  Map<String, dynamic> toJson() => _$CandidateResponseToJson(this);
}
