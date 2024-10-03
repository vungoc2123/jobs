import 'package:json_annotation/json_annotation.dart';
import 'package:phu_tho_mobile/application/constants/app_page.dart';
import 'package:phu_tho_mobile/domain/models/request/base_request/base_request.dart';

part 'industrial_park_request.g.dart';

@JsonSerializable(includeIfNull: false)
class IndustrialParkRequest extends BaseRequest {
  @JsonKey(name: "TenKCN")
  final String name;
  @JsonKey(name: "DiaDiem")
  final String location;

  const IndustrialParkRequest(
      {super.pageIndex, super.pageSize, this.name = '', this.location = ''});

  @override
  IndustrialParkRequest copyWith(
      {String? name, String? location, int? pageSize, int? pageIndex}) {
    return IndustrialParkRequest(
        name: name ?? this.name,
        location: location ?? this.location,
        pageIndex: pageIndex ?? this.pageIndex,
        pageSize: pageSize ?? this.pageSize);
  }

  factory IndustrialParkRequest.fromJson(Map<String, dynamic> json) =>
      _$IndustrialParkRequestFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$IndustrialParkRequestToJson(this);
}
