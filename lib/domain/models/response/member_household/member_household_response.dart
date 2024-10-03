import 'package:json_annotation/json_annotation.dart';

part 'member_household_response.g.dart';

@JsonSerializable()
class MemberHouseholdResponse {
  @JsonKey(name: "Id")
  final int id;
  @JsonKey(name: "HoVaTen")
  final String? fullName;
  @JsonKey(name: "GioiTinh")
  final String? gender;
  @JsonKey(name: "SoCCCD")
  final String? idCard;
  @JsonKey(name: "NgayCapCCCD")
  final String? licenseIssueDate;
  @JsonKey(name: "NoiCapCCCD")
  final String? addressLicense;
  @JsonKey(name: "NgayThangNamSinh")
  final String? dateOfBirth;
  @JsonKey(name: "QuanHeChuHoTxt")
  final String? relationShipWithHeader;
  @JsonKey(name: "TenTinh")
  final String? nameProvince;
  @JsonKey(name: "TenHuyen")
  final String? districtName;
  @JsonKey(name: "TenXa")
  final String? communeName;
  @JsonKey(name: "DiaChiChiTiet")
  final String? detailAddress;
  @JsonKey(name: "SoBHXH")
  final String? socialInsurance;
  @JsonKey(name: "DanTocTxt")
  final String? ethnicity;
  @JsonKey(name: "CCCDChuHo")
  final String? idCardHeader;
  @JsonKey(name: "SoBHYT")
  final String? healthInsurance;
  @JsonKey(name: "ThongTinHocVan")
  final String? education;
  @JsonKey(name: "ThamGiaHDKinhTe")
  final String? joinInEconomics;
  @JsonKey(name: "ThoiGianThatNghiep")
  final String? timeUnemployment;
  @JsonKey(name: "NguyenNhanKhongThamGiaHDKinhTe")
  final String? reasonNoJoinInEconomics;
  @JsonKey(name: "TrinhDoChuyenMon")
  final String? professionalQualificationlName;
  @JsonKey(name: "LinhVucGiaoDuc_DaoTao")
  final String? field;
  @JsonKey(name: "DanhSachHoatDong")
  final List<ActivityMemberResponse> activities;

  const MemberHouseholdResponse(
      {this.id = -1,
      this.communeName,
      this.districtName,
      this.detailAddress,
      this.nameProvince,
      this.gender,
      this.fullName,
      this.addressLicense,
      this.dateOfBirth,
      this.education,
      this.ethnicity,
      this.field,
      this.healthInsurance,
      this.idCard,
      this.idCardHeader,
      this.joinInEconomics,
      this.licenseIssueDate,
      this.professionalQualificationlName,
      this.reasonNoJoinInEconomics,
      this.relationShipWithHeader,
      this.socialInsurance,
      this.timeUnemployment,
      this.activities = const []});

  factory MemberHouseholdResponse.fromJson(Map<String, dynamic> json) =>
      _$MemberHouseholdResponseFromJson(json);

  Map<String, dynamic> toJson() => _$MemberHouseholdResponseToJson(this);
}

@JsonSerializable()
class ActivityMemberResponse {
  @JsonKey(name: "Id")
  final int id;
  @JsonKey(name: "ThoiGianBatDau")
  final String? startedTime;
  @JsonKey(name: "ThoiGianKetThuc")
  final String? endedTime;
  @JsonKey(name: "NoiLamViec")
  final String? workAdreess;
  @JsonKey(name: "ViTriCongViec")
  final String? workPosition;
  @JsonKey(name: "MoTaCongViec")
  final String? workDescription;
  @JsonKey(name: "TuLam_LamCongTxt")
  final String? yourSelfOrEmployed;
  @JsonKey(name: "LoaiHinhKinhTeTxt")
  final String? typeOfEconomy;
  @JsonKey(name: "IdThanhVien")
  final int idMember;
  @JsonKey(name: "TenNguoiHoatDong")
  final String? nameOfMember;

  const ActivityMemberResponse({
    this.id = -1,
    this.idMember = -1,
    this.endedTime,
    this.nameOfMember,
    this.startedTime,
    this.typeOfEconomy,
    this.workAdreess,
    this.workDescription,
    this.workPosition,
    this.yourSelfOrEmployed,
  });

  factory ActivityMemberResponse.fromJson(Map<String, dynamic> json) =>
      _$ActivityMemberResponseFromJson(json);

  Map<String, dynamic> toJson() => _$ActivityMemberResponseToJson(this);
}
