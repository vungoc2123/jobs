import 'package:json_annotation/json_annotation.dart';

part 'notification_response.g.dart';

@JsonSerializable()
class NotificationResponse {
  @JsonKey(name: 'FromUserName')
  final String? fromUserName;
  @JsonKey(name: 'Message')
  final String? message;
  @JsonKey(name: 'Link')
  final String? link;
  @JsonKey(name: 'FromUser')
  final int? fromUser;
  @JsonKey(name: 'ToUser')
  final int? toUser;
  @JsonKey(name: 'IsRead')
  final bool? isRead;
  @JsonKey(name: 'Type')
  final String? type;
  @JsonKey(name: 'CreatedDate')
  final String? createdDate;
  @JsonKey(name: 'CreatedBy')
  final String? createdBy;
  @JsonKey(name: 'CreatedID')
  final String? createdID;
  @JsonKey(name: 'UpdatedDate')
  final String? updatedDate;
  @JsonKey(name: 'UpdatedBy')
  final String? updatedBy;
  @JsonKey(name: 'UpdatedID')
  final String? updatedID;
  @JsonKey(name: 'IsDelete')
  final String? isDelete;
  @JsonKey(name: 'DeleteTime')
  final String? deleteTime;
  @JsonKey(name: 'deleteId')
  final String? deleteId;
  @JsonKey(name: 'Id')
  final int id;

  const NotificationResponse(
      {this.id = -1,
      this.type,
      this.message,
      this.link,
      this.createdDate,
      this.createdBy,
      this.createdID,
      this.deleteId,
      this.deleteTime,
      this.fromUser,
      this.fromUserName,
      this.isDelete,
      this.isRead,
      this.toUser,
      this.updatedBy,
      this.updatedDate,
      this.updatedID});

  factory NotificationResponse.fromJson(Map<String, dynamic> json) => _$NotificationResponseFromJson(json);

  Map<String, dynamic> toJson() => _$NotificationResponseToJson(this);
}
