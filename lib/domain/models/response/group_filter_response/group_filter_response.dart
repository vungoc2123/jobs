import 'package:json_annotation/json_annotation.dart';

part 'group_filter_response.g.dart';

@JsonSerializable()
class GroupFilterResponse{
  @JsonKey(name: "Disabled")
  final bool disabled;
  @JsonKey(name: "Name")
  final String name;

  const GroupFilterResponse({this.name = '', this.disabled = false});

  factory GroupFilterResponse.fromJson(Map<String,dynamic> json) => _$GroupFilterResponseFromJson(json);
  Map<String,dynamic> toJson() => _$GroupFilterResponseToJson(this);
}