import 'package:json_annotation/json_annotation.dart';
import 'package:phu_tho_mobile/domain/models/response/reply/reply_response.dart';

part 'question_response.g.dart';

@JsonSerializable()
class QuestionResponse {
  @JsonKey(name: "Id")
  final int id;

  @JsonKey(name: "Title")
  final String title;

  @JsonKey(name: "LinhVuc")
  final String field;

  @JsonKey(name: "Slug")
  final String slug;

  @JsonKey(name: "NoiDung")
  final String content;

  @JsonKey(name: "NguoiHoiDap")
  final String questioner;

  @JsonKey(name: "Email")
  final String email;

  @JsonKey(name: "CauTraLois")
  final List<ReplyResponse> listReply;

  const QuestionResponse(
      {this.content = '',
      this.id = 0,
      this.title = '',
      this.slug = '',
      this.email = '',
      this.field = '',
      this.listReply = const [],
      this.questioner = ''});

  factory QuestionResponse.fromJson(Map<String,dynamic> json) => _$QuestionResponseFromJson(json);
  Map<String,dynamic> toJson() => _$QuestionResponseToJson(this);
}
