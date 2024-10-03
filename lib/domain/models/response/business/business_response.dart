import 'package:json_annotation/json_annotation.dart';
import 'package:phu_tho_mobile/application/configs/env_configs.dart';
import 'package:phu_tho_mobile/domain/models/common/item_filter.dart';

part 'business_response.g.dart';

@JsonSerializable()
class BusinessResponse implements ItemFilter {
  @JsonKey(name: "Id")
  final int id;
  @JsonKey(name: "MaSoThue")
  final String taxCode;
  @JsonKey(name: "TenDoanhNghiep")
  final String nameBusiness;
  @JsonKey(name: "PathIMG")
  final String imgPath;
  @JsonKey(name: "DiaChi")
  final String address;
  @JsonKey(name: "LoaiDoanhNghiepTxt")
  final String typeBusiness;
  @JsonKey(name: "KhuCongNghiepTxt")
  final String industrialPark;
  @JsonKey(name: "SoDienThoai")
  final String phone;
  @JsonKey(name: "NguoiDungDau")
  final String leader;
  @JsonKey(name: "TinhTxt")
  final String province;
  @JsonKey(name: "HuyenTxt")
  final String district;
  @JsonKey(name: "XaTxt")
  final String commune;
  @JsonKey(name: "SanPhamChinh")
  final String mainProduct;
  @JsonKey(name: "Email")
  final String email;
  @JsonKey(name: "NganhNgheKinhDoanhTxt")
  final String businessProfession;
  @JsonKey(name: "HoTenNguoiLienHe")
  final String nameConatact;
  @JsonKey(name: "SoDienThoaiLienHe")
  final String phoneContact;
  @JsonKey(name: "EmailLienHe")
  final String emailContact;
  @JsonKey(name: "TinhTrangHoatDongTxt")
  final String status;
  @JsonKey(name: "GioiThieuCongTy")
  final String introduce;
  @JsonKey(name: "QuyMoDonVi")
  final String scale;

  String getImagePath() {
    if (imgPath.isNotEmpty && imgPath[0] == "/") {
      return "${EnvConfigs.resourceUrl}$imgPath";
    }
    return "${EnvConfigs.resourceUrl}/$imgPath";
  }

  const BusinessResponse(
      {this.id = -1,
      this.taxCode = '',
      this.address = '',
      this.status = '',
      this.nameBusiness = '',
      this.phone = '',
      this.email = '',
      this.businessProfession = '',
      this.commune = '',
      this.district = '',
      this.emailContact = '',
      this.imgPath = '',
      this.industrialPark = '',
      this.leader = '',
      this.mainProduct = '',
      this.nameConatact = '',
      this.phoneContact = '',
      this.province = '',
      this.typeBusiness = '',
      this.introduce = '',
      this.scale = ''});

  factory BusinessResponse.fromJson(Map<String, dynamic> json) =>
      _$BusinessResponseFromJson(json);

  Map<String, dynamic> toJson() => _$BusinessResponseToJson(this);

  @override
  String getTitle() {
    return nameBusiness;
  }

  @override
  String getValues() {
    return id.toString();
  }
}
