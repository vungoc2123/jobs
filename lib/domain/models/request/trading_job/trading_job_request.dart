import 'package:json_annotation/json_annotation.dart';
import 'package:phu_tho_mobile/application/constants/app_page.dart';
import 'package:phu_tho_mobile/domain/models/request/base_request/base_request.dart';
part 'trading_job_request.g.dart';

@JsonSerializable(includeIfNull: false)
class TradingJobRequest extends BaseRequest {
  @JsonKey(name: "MaPhienFilter")
  final String? code;
  @JsonKey(name: "TenFilter")
  final String? name;
  @JsonKey(name: "FromBatDauFilter")
  final String? timeStart;
  @JsonKey(name: "ToKetThucFilter")
  final String? timeEnd;

  const TradingJobRequest(
      {super.pageIndex,
      super.pageSize,
      this.code,
      this.name,
      this.timeStart,
      this.timeEnd});

  @override
  TradingJobRequest copyWith(
      {int? pageSize,
      int? pageIndex,
      String? code,
      String? name,
      String? timeStart,
      String? timeEnd}) {
    return TradingJobRequest(
        pageSize: pageSize ?? this.pageSize,
        pageIndex: pageIndex ?? this.pageIndex,
        name: name ?? this.name,
        code: code ?? this.code,
        timeEnd: timeEnd ?? this.timeEnd,
        timeStart: timeStart ?? this.timeStart);
  }
  factory TradingJobRequest.fromJson(Map<String, dynamic> json) =>
      _$TradingJobRequestFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$TradingJobRequestToJson(this);
}
