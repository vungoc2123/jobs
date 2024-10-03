import 'package:json_annotation/json_annotation.dart';
import 'package:phu_tho_mobile/application/configs/env_configs.dart';

part 'job_response.g.dart';

@JsonSerializable()
class JobResponse {
  @JsonKey(name: "Id")
  final int id;
  @JsonKey(name: "Title")
  final String title;
  @JsonKey(name: 'NgayBatDauTuyen')
  final String dateStart;
  @JsonKey(name: 'NgayHetHan')
  final String dateEnd;
  @JsonKey(name: "TenTinh")
  final String nameProvince;
  @JsonKey(name: 'MucLuong')
  final String salary;
  @JsonKey(name: 'SoLuongTuyen')
  final int numberOfVacancies;
  @JsonKey(name: 'GioiTinh')
  final String gender;
  @JsonKey(name: 'YeuCauKinhNghiem')
  final String eprRequired;
  @JsonKey(name: 'Tuoi')
  final String age;
  @JsonKey(name: 'ChucVuTuyenDung')
  final String recruitmentPosition;
  @JsonKey(name: 'ViTriTuyenDung')
  final String jobPosition;
  @JsonKey(name: 'TinhChatCongViec')
  final String natureOfWork;
  @JsonKey(name: 'YeuCauTrinhDoChuyenMon')
  final String professionalQualificationsRequired;
  @JsonKey(name: 'NganhNgheTuyenDung')
  final String recruitmentIndustry;
  @JsonKey(name: 'ThoiGianLamViec')
  final String workingTime;
  @JsonKey(name: 'TenDoanhNghiep')
  final String businessName;
  @JsonKey(name: 'PathIMG')
  final String image;
  @JsonKey(name: 'MoTaCongViec')
  final String description;
  @JsonKey(name: 'YeuCauCongViec')
  final String jobRequirement;
  @JsonKey(name: 'QuyenLoi')
  final String benefit;
  @JsonKey(name: 'IdDoanhNghiep')
  final int idBusiness;


  String getImagePath() {
    if (image.isNotEmpty && image[0] == "/") {
      return "${EnvConfigs.resourceUrl}/Uploads$image";
    }
    return "${EnvConfigs.resourceUrl}/Uploads/$image";
  }

  const JobResponse(
      {this.id = 0,
      this.title = '',
      this.dateStart = '',
      this.dateEnd = '',
      this.nameProvince = '',
      this.salary = '',
      this.numberOfVacancies = 0,
      this.gender = '',
      this.eprRequired = '',
      this.age = '',
      this.recruitmentPosition = '',
      this.jobPosition = '',
      this.natureOfWork = '',
      this.professionalQualificationsRequired = '',
      this.recruitmentIndustry = '',
      this.workingTime = '',
      this.businessName = '',
      this.description = '',
      this.image = '',
      this.benefit = '',
      this.jobRequirement = '',this.idBusiness=-1});

  factory JobResponse.fromJson(Map<String, dynamic> json) =>
      _$JobResponseFromJson(json);

  Map<String, dynamic> toJson() => _$JobResponseToJson(this);
}
