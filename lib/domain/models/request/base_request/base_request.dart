import 'package:json_annotation/json_annotation.dart';
import 'package:phu_tho_mobile/application/constants/app_page.dart';
part 'base_request.g.dart';

@JsonSerializable()
class BaseRequest{
  @JsonKey(name: "PageIndex")
  final int pageIndex;
  @JsonKey(name: "PageSize")
  final int pageSize;

  const BaseRequest({this.pageIndex = 1, this.pageSize = AppPage.pageSize});

  BaseRequest copyWith({int? pageIndex, int? pageSize}){
    return BaseRequest(
      pageIndex: pageIndex ?? this.pageIndex,
      pageSize: pageSize ?? this.pageSize
    );
  }

  factory BaseRequest.fromJson(Map<String,dynamic> json) => _$BaseRequestFromJson(json);
  Map<String, dynamic> toJson() => _$BaseRequestToJson(this);

}