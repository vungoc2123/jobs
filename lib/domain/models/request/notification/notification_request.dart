import 'package:json_annotation/json_annotation.dart';
import 'package:phu_tho_mobile/application/constants/app_page.dart';

part 'notification_request.g.dart';

@JsonSerializable(includeIfNull: false)
class NotificationRequest {
  final int pageIndex;
  final int pageSize;
  final bool? isReadFilter;

  const NotificationRequest(
      {this.pageIndex = 1,
      this.pageSize = AppPage.pageSize,
      this.isReadFilter});

  NotificationRequest copyWith(
      {int? pageIndex, int? pageSize, bool? isReadFilter}) {
    return NotificationRequest(
        pageIndex: pageIndex ?? this.pageIndex,
        pageSize: pageSize ?? this.pageSize,
        isReadFilter: isReadFilter ?? this.isReadFilter);
  }

  factory NotificationRequest.fromJson(Map<String, dynamic> json) =>
      _$NotificationRequestFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$NotificationRequestToJson(this);
}
