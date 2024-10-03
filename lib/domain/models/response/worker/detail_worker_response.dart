import 'package:json_annotation/json_annotation.dart';
import 'package:phu_tho_mobile/domain/models/response/document/document_response.dart';
import 'package:phu_tho_mobile/domain/models/response/worker/worker_response.dart';

part 'detail_worker_response.g.dart';

@JsonSerializable()
class DetailWorkerResponse {
  final WorkerResponse objInfo;
  @JsonKey(name: "ListTheViSa")
  final List<DocumentResponse> listTheViSa;
  @JsonKey(name: "ListGiayPhepNguoiLaoDong")
  final List<DocumentResponse> listWorkPermit;

  const DetailWorkerResponse(
      {this.objInfo = const WorkerResponse(),
      this.listWorkPermit = const [],
      this.listTheViSa = const []});

  factory DetailWorkerResponse.fromJson(Map<String, dynamic> json) =>
      _$DetailWorkerResponseFromJson(json);

  Map<String, dynamic> toJson() => _$DetailWorkerResponseToJson(this);
}
