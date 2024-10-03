import 'package:json_annotation/json_annotation.dart';
import 'package:phu_tho_mobile/application/constants/app_page.dart';
import 'package:phu_tho_mobile/domain/models/request/base_request/base_request.dart';

part 'household_request.g.dart';

@JsonSerializable(includeIfNull: false)
class HouseholdRequest extends BaseRequest {
  @JsonKey(name: "HoVaTen_ChuHoFilter")
  final String? fullNameOfHouseholdHead;
  @JsonKey(name: "SoHoKhauFilter")
  final String? householdRegistrationBook;
  @JsonKey(name: "SoCCCD_ChuHoFilter")
  final String? idNumberOfHouseholdHead;
  @JsonKey(name: "huyenFilter")
  final String? districtName;
  @JsonKey(name: "xaFilter")
  final String? communeName;
  @JsonKey(name: "diaChiChiTietFilter")
  final String? detailAddress;
  @JsonKey(name: "khuVucFilter")
  final String? area;

  const HouseholdRequest(
      {this.detailAddress,
      this.idNumberOfHouseholdHead,
      this.fullNameOfHouseholdHead,
      this.districtName,
      this.communeName,
      this.area,
      this.householdRegistrationBook,
      super.pageIndex,
      super.pageSize});

  @override
  HouseholdRequest copyWith(
      {int? pageIndex,
      int? pageSize,
      String? area,
      String? detailAddress,
      String? communeName,
      String? districtName,
      String? idNumberOfHouseholdHead,
      String? householdRegistrationBook,
      String? fullNameOfHouseholdHead}) {
    return HouseholdRequest(
        area: area ?? this.area,
        communeName: communeName ?? this.communeName,
        detailAddress: detailAddress ?? this.detailAddress,
        districtName: districtName ?? this.districtName,
        fullNameOfHouseholdHead:
            fullNameOfHouseholdHead ?? this.fullNameOfHouseholdHead,
        householdRegistrationBook:
            householdRegistrationBook ?? this.householdRegistrationBook,
        idNumberOfHouseholdHead:
            idNumberOfHouseholdHead ?? this.idNumberOfHouseholdHead,
        pageIndex: pageIndex ?? this.pageIndex,
        pageSize: pageSize ?? this.pageSize);
  }

  factory HouseholdRequest.fromJson(Map<String, dynamic> json) =>
      _$HouseholdRequestFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$HouseholdRequestToJson(this);
}
