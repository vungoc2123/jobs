
import 'package:json_annotation/json_annotation.dart';
part 'tag_response.g.dart';

@JsonSerializable(includeIfNull: false)
class TagResponse {
  @JsonKey(name: "TenTag")
  final String nameTag;

  const TagResponse({this.nameTag = ''});

  factory TagResponse.fromJson(Map<String,dynamic> json) => _$TagResponseFromJson(json);
  Map<String,dynamic> toJson() => _$TagResponseToJson(this);
}