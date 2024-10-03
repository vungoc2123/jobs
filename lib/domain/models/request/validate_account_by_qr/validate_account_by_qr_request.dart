import 'package:json_annotation/json_annotation.dart';

part 'validate_account_by_qr_request.g.dart';

@JsonSerializable(includeIfNull: false)
class ValidateAccountByQrRequest {
  final String token;

  @JsonKey(name: 'str')
  final String qrCode;

  const ValidateAccountByQrRequest({required this.token, required this.qrCode});

  factory ValidateAccountByQrRequest.fromJson(Map<String, dynamic> json) => _$ValidateAccountByQrRequestFromJson(json);

  Map<String, dynamic> toJson() => _$ValidateAccountByQrRequestToJson(this);
}
