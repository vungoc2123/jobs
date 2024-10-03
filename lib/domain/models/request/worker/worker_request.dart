import 'package:json_annotation/json_annotation.dart';
import 'package:phu_tho_mobile/application/constants/app_page.dart';
import 'package:phu_tho_mobile/domain/models/request/base_request/base_request.dart';

part 'worker_request.g.dart';

@JsonSerializable(includeIfNull: false)
class WorkerRequest extends BaseRequest {
  @JsonKey(name: "IdDoanhNghiep")
  final int? idBusiness;
  @JsonKey(name: "HoTen")
  final String? name;
  @JsonKey(name: "Email")
  final String? email;
  @JsonKey(name: "SoDienThoai")
  final String? phoneNumber;

  const WorkerRequest(
      {super.pageIndex,
      super.pageSize,
      this.idBusiness,
      this.phoneNumber,
      this.email,
      this.name});

  @override
  WorkerRequest copyWith(
      {int? pageIndex,
      int? pageSize,
      String? name,
      String? email,
      int? idBusiness,
      String? phoneNumber}) {
    return WorkerRequest(
        pageSize: pageSize ?? this.pageSize,
        pageIndex: pageIndex ?? this.pageIndex,
        name: name ?? this.name,
        email: email ?? this.email,
        idBusiness: idBusiness ?? this.idBusiness,
        phoneNumber: phoneNumber ?? this.phoneNumber);
  }

  factory WorkerRequest.fromJson(Map<String, dynamic> json) =>
      _$WorkerRequestFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$WorkerRequestToJson(this);
}
