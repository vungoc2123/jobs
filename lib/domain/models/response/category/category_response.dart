
import 'package:json_annotation/json_annotation.dart';
part 'category_response.g.dart';

@JsonSerializable(includeIfNull: false)
class CategoryResponse{
  @JsonKey(name: "TenDanhMuc")
  final String nameCate;

  const CategoryResponse({this.nameCate = ''});

  factory CategoryResponse.fromJson(Map<String,dynamic> json) => _$CategoryResponseFromJson(json);
  Map<String,dynamic> toJson() => _$CategoryResponseToJson(this);
}