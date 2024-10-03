import 'package:json_annotation/json_annotation.dart';
import 'package:phu_tho_mobile/application/configs/env_configs.dart';
import 'package:phu_tho_mobile/domain/models/response/category/category_response.dart';
import 'package:phu_tho_mobile/domain/models/response/tag/tag_response.dart';

part 'news_response.g.dart';

@JsonSerializable(includeIfNull: false)
class NewsResponse {
  @JsonKey(name: "Id")
  final int id;
  @JsonKey(name: "Title")
  final String title;
  @JsonKey(name: "MoTa")
  final String describe;
  @JsonKey(name: "NoiDung")
  final String content;
  @JsonKey(name: "AnhDaiDien")
  final String avatar;
  @JsonKey(name: "NgayDangTinFormatted")
  final String datePosting;
  @JsonKey(name: "NgayHetHieuLucFormatted")
  final String dateExpiration;
  @JsonKey(name: "NgayHienThiFormatted")
  final String dateShow;
  @JsonKey(name: "GhiChu")
  final String note;
  @JsonKey(name: "Slug")
  final String slug;
  @JsonKey(name: "LuotXem")
  final int views;
  @JsonKey(name: "LuotThich")
  final int likes;
  @JsonKey(name: "LuotKhongThich")
  final int disLikes;
  @JsonKey(name: "DanhSachTag")
  final List<TagResponse>? listTag;
  @JsonKey(name: "DanhSachChuyenMuc")
  final List<CategoryResponse>? listCate;

  const NewsResponse(
      {this.title = '',
      this.id = 0,
      this.content = '',
      this.avatar = '',
      this.dateExpiration = '',
      this.datePosting = '',
      this.dateShow = '',
      this.describe = '',
      this.disLikes = 0,
      this.likes = 0,
      this.listCate = const [],
      this.listTag = const [],
      this.note = '',
      this.slug = '',
      this.views = 0});

  String getAvatar() {
    return '${EnvConfigs.resourceUrl}/$avatar';
  }

  factory NewsResponse.fromJson(Map<String, dynamic> json) =>
      _$NewsResponseFromJson(json);

  Map<String, dynamic> toJson() => _$NewsResponseToJson(this);
}
