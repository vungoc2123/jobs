import 'package:json_annotation/json_annotation.dart';
part 'trading_job_response.g.dart';

@JsonSerializable()
class TradingJobResponse {
  @JsonKey(name: "MaPhien")
  final String code;
  @JsonKey(name: "Ten")
  final String name;
  @JsonKey(name: "MoTa")
  final String description;
  @JsonKey(name: "BatDau")
  final String timeStart;
  @JsonKey(name: "KetThuc")
  final String timeEnd;
  @JsonKey(name: "Hotline")
  final String hotline;
  @JsonKey(name: "DiaDiem")
  final String location;

  const TradingJobResponse(
      {this.code = '',
      this.name = '',
      this.description = '',
      this.timeStart = '',
      this.timeEnd = '',
      this.hotline = '',
      this.location = ''});

  factory TradingJobResponse.fromJson(Map<String,dynamic> json) => _$TradingJobResponseFromJson(json);
  Map<String,dynamic> toJson() => _$TradingJobResponseToJson(this);

}
