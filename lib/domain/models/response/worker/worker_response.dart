import 'package:json_annotation/json_annotation.dart';

part 'worker_response.g.dart';

@JsonSerializable()
class WorkerResponse {
  @JsonKey(name: "Id")
  final int id;
  @JsonKey(name: "HoTen")
  final String? fullName;
  @JsonKey(name: "DiaChi")
  final String? address;
  @JsonKey(name: "SoDienThoai")
  final String? phoneNumber;
  @JsonKey(name: "Email")
  final String? email;
  @JsonKey(name: "DiaChiNoiLamViec")
  final String? workingAddress;
  @JsonKey(name: "CCCD")
  final String? identification;
  @JsonKey(name: "LuongCoBan")
  final int? baseSalary;
  @JsonKey(name: "ChucDanh")
  final String? position;
  @JsonKey(name: "MaSoBHXH")
  final String? codeInsurance;
  @JsonKey(name: "HeSoLuong")
  final int? salaryMultiplier;
  @JsonKey(name: "PhuCapChucVu")
  final int? positionAllowance;
  @JsonKey(name: "PhuCapThamNienVK")
  final int? seniorityAllowanceForPublicEmployees;
  @JsonKey(name: "PhuCapThamNienNghe")
  final int? seniorityAllowanceJob;
  @JsonKey(name: "PhuCapLuong")
  final int? salaryAllowance;
  @JsonKey(name: "PhuCapCacKhoanBoSung")
  final int? additionalAllowances;
  @JsonKey(name: "isNgeDocHai")
  final bool? isNgeDocHai;
  @JsonKey(name: "GhiChu")
  final String? note;
  @JsonKey(name: "TenDoanhNghiepText")
  final String? nameBusiness;
  @JsonKey(name: "DoanhNghiepText")
  final String? businessText;
  @JsonKey(name: "TenDoanhNghiepNuocNgoai")
  final String? nameBusinessForeign;
  @JsonKey(name: "QuocTichText")
  final String? nationality;
  @JsonKey(name: "NganhNgheText")
  final String? industry;
  @JsonKey(name: "GioiTinhText")
  final String? gender;
  @JsonKey(name: "LoaiHopDongText")
  final String? contractTypeText;
  @JsonKey(name: "TrinhDoChuyenMonText")
  final String? professionalQualificationText;
  @JsonKey(name: "LinhVucNgheNghiepText")
  final String? fieldOfOccupationText;
  @JsonKey(name: "ChucVuText")
  final String? positionText;
  @JsonKey(name: "NgaySinhText")
  final String? dateOfBirthText;
  @JsonKey(name: "NgayBatDauNganhNgheDocHaiText")
  final String? dateStartedOccupationDocHaiText;
  @JsonKey(name: "NgayKetThucNganhNgheDocHaiText")
  final String? dateEndedOccupationDocHaiText;
  @JsonKey(name: "NgayBBatDauHDLDKhongThoiHanText")
  final String? dateStartedPermanentEmploymentContractText;
  @JsonKey(name: "NgayBatDauHDCoThoiHanText")
  final String? dateStartedFixedTermContractText;
  @JsonKey(name: "NgayKetThucHDCoThoiHanText")
  final String? dateEndedFixedTermContractText;
  @JsonKey(name: "NgayBatDauHDThuViecText")
  final String? dateStartedProbationaryPeriodText;
  @JsonKey(name: "NgayKetThucHDThuViecText")
  final String? dateEndedProbationaryPeriodText;
  @JsonKey(name: "NgayBatDauDongBHXHText")
  final String? dateStartedSocialInsuranceText;
  @JsonKey(name: "NgayKetThucDongBHXHText")
  final String? dateEndedSocialInsuranceText;

  const WorkerResponse(
      {this.id = 0,
      this.fullName,
      this.nameBusiness,
      this.address,
      this.email,
      this.phoneNumber,
      this.gender,
      this.baseSalary,
      this.codeInsurance,
      this.contractTypeText,
      this.dateEndedFixedTermContractText,
      this.dateEndedOccupationDocHaiText,
      this.dateEndedProbationaryPeriodText,
      this.dateEndedSocialInsuranceText,
      this.dateOfBirthText,
      this.dateStartedFixedTermContractText,
      this.dateStartedOccupationDocHaiText,
      this.dateStartedPermanentEmploymentContractText,
      this.dateStartedProbationaryPeriodText,
      this.dateStartedSocialInsuranceText,
      this.fieldOfOccupationText,
      this.identification,
      this.industry,
      this.isNgeDocHai,
      this.nationality,
      this.note,
      this.position,
      this.positionAllowance,
      this.positionText,
      this.professionalQualificationText,
      this.salaryAllowance,
      this.salaryMultiplier,
      this.seniorityAllowanceForPublicEmployees,
      this.seniorityAllowanceJob,
      this.workingAddress,
      this.additionalAllowances,
      this.nameBusinessForeign,
      this.businessText});

  factory WorkerResponse.fromJson(Map<String, dynamic> json) =>
      _$WorkerResponseFromJson(json);

  Map<String, dynamic> toJson() => _$WorkerResponseToJson(this);
}
