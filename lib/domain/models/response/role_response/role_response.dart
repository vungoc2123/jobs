import 'package:json_annotation/json_annotation.dart';

part 'role_response.g.dart';

@JsonSerializable()
class RoleResponse {
  @JsonKey(name: "Name")
  final String? name;
  @JsonKey(name: "Code")
  final String? code;
  @JsonKey(name: "Id")
  final int id;

  const RoleResponse({this.name, this.code, required this.id});

  factory RoleResponse.fromJson(Map<String, dynamic> json) =>
      _$RoleResponseFromJson(json);

  Map<String, dynamic> toJson() => _$RoleResponseToJson(this);
}
