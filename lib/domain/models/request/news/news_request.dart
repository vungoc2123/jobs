import 'package:json_annotation/json_annotation.dart';
import 'package:phu_tho_mobile/application/constants/app_page.dart';
import 'package:phu_tho_mobile/domain/models/request/base_request/base_request.dart';

part 'news_request.g.dart';

@JsonSerializable(includeIfNull: false)
class NewsRequest extends BaseRequest {
  final String? titleFilter;
  @JsonKey(name: "ngayDangTinFilter")
  final String? datePost;
  @JsonKey(name: "ngayHienThiFilter")
  final String? dateShow;
  @JsonKey(name: "ngayHetHieuLucFilter")
  final String? dateExpiration;
  @JsonKey(name: "noiDungFilter")
  final String? content;
  @JsonKey(name: "thoiGIanFilter")
  final String? timeFilter;

  const NewsRequest(
      {this.dateShow,
      this.dateExpiration,
      this.content,
      this.datePost,
      this.titleFilter,
      this.timeFilter,
      super.pageIndex,
      super.pageSize});

  NewsRequest copyWith(
      {int? pageIndex,
      int? pageSize,
      String? titleFilter,
      String? datePost,
      String? dateShow,
        String? timeFilter,
      String? dateExpiration,
      String? content}) {
    return NewsRequest(
        pageSize: pageSize ?? super.pageSize,
        pageIndex: pageIndex ?? super.pageIndex,
        content: content ?? this.content,
        dateExpiration: dateExpiration ?? this.dateExpiration,
        datePost: datePost ?? this.datePost,
        dateShow: dateShow ?? this.dateShow,
        timeFilter: timeFilter ?? this.timeFilter,
        titleFilter: titleFilter ?? this.titleFilter);
  }

  factory NewsRequest.fromJson(Map<String, dynamic> json) =>
      _$NewsRequestFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$NewsRequestToJson(this);
}
