import 'package:json_annotation/json_annotation.dart';
import 'package:phu_tho_mobile/application/configs/env_configs.dart';

part 'banner_response.g.dart';

@JsonSerializable()
class BannerResponse {
  @JsonKey(name: "FileAnhDinhKem")
  final String fileAttached;
  @JsonKey(name: "LinkLienKet")
  final String link;
  @JsonKey(name: "Title")
  final String title;
  @JsonKey(name: 'MoTa')
  final String description;
  @JsonKey(name: "StartDate")
  final String startDate;
  @JsonKey(name: "EndDate")
  final String endDate;

  const BannerResponse(
      {this.fileAttached = '',
      this.link = '',
      this.title = '',
      this.endDate = '',
      this.description = '',
      this.startDate = ''});

  String getFileAttached() {
    if (fileAttached[0] == "/") {
      return '${EnvConfigs.resourceUrl}/Uploads$fileAttached';
    }
    return "${EnvConfigs.resourceUrl}/Uploads/$fileAttached";
  }

  String getLink(){
    if (link[0] == "/") {
      return EnvConfigs.resourceUrl + link;
    }
    return "${EnvConfigs.resourceUrl}/$link";
  }

  factory BannerResponse.fromJson(Map<String, dynamic> json) =>
      _$BannerResponseFromJson(json);

  Map<String, dynamic> toJson() => _$BannerResponseToJson(this);
}
