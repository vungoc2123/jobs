import 'package:json_annotation/json_annotation.dart';
import 'package:phu_tho_mobile/domain/models/common/item_filter.dart';
import 'package:phu_tho_mobile/domain/models/response/group_filter_response/group_filter_response.dart';

part 'filter_response.g.dart';

@JsonSerializable()
class FilterResponse implements ItemFilter {
  @JsonKey(name: "Disabled")
  final bool disabled;
  @JsonKey(name: "Selected")
  final bool selected;
  @JsonKey(name: "Group")
  final GroupFilterResponse? group;
  @JsonKey(name: "Text")
  final String text;
  @JsonKey(name: "Value")
  final String value;

  const FilterResponse(
      {this.disabled = false,
      this.value = '',
      this.selected = false,
      this.text = '',
      this.group});

  factory FilterResponse.fromJson(Map<String, dynamic> json) =>
      _$FilterResponseFromJson(json);

  Map<String, dynamic> toJson() => _$FilterResponseToJson(this);

  @override
  String getTitle() {
    return text;
  }

  @override
  String getValues() {
    return value;
  }
}
