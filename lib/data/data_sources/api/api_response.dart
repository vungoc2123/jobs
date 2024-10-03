import 'package:json_annotation/json_annotation.dart';

part 'api_response.g.dart';

@JsonSerializable(genericArgumentFactories: true)
class ApiResponse<T> {
  @JsonKey(name: "Status")
  final bool status;
  @JsonKey(name: "Data")
  final T? data;
  @JsonKey(name: "ErrorCode")
  final String? errorCode;
  @JsonKey(name: "Message")
  final String message;

  const ApiResponse(
      {this.data, this.status = false, this.message = "", this.errorCode = ""});

  factory ApiResponse.fromJson(
          Map<String, dynamic> json, T Function(Object? json) fromJsonT) =>
      _$ApiResponseFromJson(json, fromJsonT);

  Map<String, dynamic> toJson(Object? Function(T value) toJsonT) =>
      _$ApiResponseToJson(this, toJsonT);
}

@JsonSerializable(genericArgumentFactories: true)
class ListDataResponse<T> {
  @JsonKey(name: "ListItem")
  final List<T> listItem;
  @JsonKey(name: "HasNextPage")
  final bool hasNextPage;

  const ListDataResponse({
    this.listItem = const [],
    this.hasNextPage = false,
  });

  factory ListDataResponse.fromJson(
          Map<String, dynamic> json, T Function(Object? json) fromJsonT) =>
      _$ListDataResponseFromJson(json, fromJsonT);

  Map<String, dynamic> toJson(Object? Function(T value) toJsonT) =>
      _$ListDataResponseToJson(this, toJsonT);
}
