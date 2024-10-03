import 'package:json_annotation/json_annotation.dart';

part 'info_contact_response.g.dart';

@JsonSerializable()
class InfoContactResponse {
  @JsonKey(name: "Email")
  final String email;
  @JsonKey(name: "Phone")
  final String phone;
  @JsonKey(name: "Address")
  final String address;
  @JsonKey(name: "Name")
  final String name;
  @JsonKey(name: "IframeMap")
  final String iframeMap;

  const InfoContactResponse(
      {this.email = '',
      this.phone = '',
      this.address = '',
      this.name = '',
      this.iframeMap = ''});

  String getIframe() {
    return iframeMap.replaceAll(RegExp(r'height:\d+px'), 'height:900px');
  }

  factory InfoContactResponse.fromJson(Map<String, dynamic> json) =>
      _$InfoContactResponseFromJson(json);

  Map<String, dynamic> toJson() => _$InfoContactResponseToJson(this);
}
