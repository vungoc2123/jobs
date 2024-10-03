import 'package:json_annotation/json_annotation.dart';
import 'package:phu_tho_mobile/domain/models/request/base_request/base_request.dart';

import '../../../../application/constants/app_page.dart';
part 'utilities_request.g.dart';

@JsonSerializable(includeIfNull: false)
class UtilitiesRequest extends BaseRequest {
  final String? title;

  const UtilitiesRequest({this.title, super.pageIndex, super.pageSize});

  UtilitiesRequest copyWith({String? title, int? pageIndex, int? pageSize}) {
    return UtilitiesRequest(
        pageIndex: pageIndex ?? this.pageIndex,
        pageSize: pageSize ?? this.pageSize,
        title: title ?? this.title);
  }

  factory UtilitiesRequest.fromJson(Map<String,dynamic> json) => _$UtilitiesRequestFromJson(json);
  Map<String,dynamic> toJson() => _$UtilitiesRequestToJson(this);
}
