import 'package:json_annotation/json_annotation.dart';
import 'package:phu_tho_mobile/application/enums/permission_operator.dart';
import 'package:jwt_decoder/jwt_decoder.dart';

part 'logger_info_model.g.dart';

@JsonSerializable()
class LoggerInfoModel {
  final int accountId;
  final DateTime expireTime;
  final String accessToken;

  const LoggerInfoModel({required this.accountId, required this.expireTime, required this.accessToken});

  factory LoggerInfoModel.fromJson(Map<String, dynamic> json) => _$LoggerInfoModelFromJson(json);

  Map<String, dynamic> toJson() => _$LoggerInfoModelToJson(this);

  bool get isExpired => DateTime.now().isAfter(expireTime);

  List<PermissionOperator> get operators {
    final decodedToken = JwtDecoder.decode(accessToken);
    final operatorData = decodedToken['_operator'] as String?;

    return operatorData?.split(";").map((operator) => PermissionOperator.fromString(operator)).toList() ?? [];
  }
}
