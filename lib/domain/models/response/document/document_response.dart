import 'package:json_annotation/json_annotation.dart';

part 'document_response.g.dart';

@JsonSerializable()
class DocumentResponse {
  @JsonKey(name: "Type")
  final String? type;
  @JsonKey(name: "SoGiayTo")
  final String? numberCode;
  @JsonKey(name: "LoaiGiayTo")
  final String? typeDocument;
  @JsonKey(name: "PathDocument")
  final String? pathDocument;
  @JsonKey(name: "LoaiTheText")
  final String? typeCard;
  @JsonKey(name: "ngayCapText")
  final String? dateStart;
  @JsonKey(name: "NgayHetHanText")
  final String? dateEnd;

  const DocumentResponse({this.type,this.dateStart,this.dateEnd,this.numberCode,this.pathDocument,this.typeCard,this.typeDocument});

  factory DocumentResponse.fromJson(Map<String, dynamic> json) => _$DocumentResponseFromJson(json);

  Map<String, dynamic> toJson() => _$DocumentResponseToJson(this);
}