
import 'package:json_annotation/json_annotation.dart';

part 'reply_response.g.dart';

@JsonSerializable()
class ReplyResponse{
  @JsonKey(name: "NoiDung")
  final String content;
  @JsonKey(name: "NguoiTraLoi")
  final String respondent;
  @JsonKey(name: "IsPublish")
  final bool isPublic;

  const ReplyResponse({this.content = '', this.isPublic = false, this.respondent = '',});

  factory ReplyResponse.fromJson(Map<String,dynamic> json) => _$ReplyResponseFromJson(json);
  Map<String,dynamic> toJson() => _$ReplyResponseToJson(this);
}