import 'package:json_annotation/json_annotation.dart';

part 'terms_of_use_response.g.dart';

@JsonSerializable()
class TermsOfUseResponse {
  @JsonKey(name: "Ten")
  final String name;
  @JsonKey(name: "FileDinhKem")
  final String file;
  @JsonKey(name: "Mota")
  final String? description;
  @JsonKey(name: "IsDownload")
  final String isDownload;

  const TermsOfUseResponse({
    this.name = '',
    this.file = '',
    this.description,
    this.isDownload = '',
  });

  factory TermsOfUseResponse.fromJson(Map<String,dynamic> json) => _$TermsOfUseResponseFromJson(json);
  Map<String,dynamic> toJson() => _$TermsOfUseResponseToJson(this);
}
