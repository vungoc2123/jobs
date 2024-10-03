import 'package:equatable/equatable.dart';
import 'package:phu_tho_mobile/application/enums/load_status.dart';
import 'package:phu_tho_mobile/application/enums/path_news.dart';
import 'package:phu_tho_mobile/domain/models/request/news/news_request.dart';
import 'package:phu_tho_mobile/domain/models/response/news/news_response.dart';

class NewsCommonState extends Equatable {
  final NewsPath nameScreen;
  final LoadStatus status;
  final List<NewsResponse> listNews;

  final bool canLoad;
  final NewsRequest request;

  final bool openSearch;

  const NewsCommonState(
      {this.request = const NewsRequest(),
      this.openSearch = false,
      this.nameScreen = NewsPath.unknown,
      this.canLoad = false,
      this.status = LoadStatus.initial,
      this.listNews = const []});

  NewsCommonState copyWith(
      {LoadStatus? status,
      NewsPath? nameScreen,
      bool? openSearch,
      List<NewsResponse>? listNews,
      bool? canLoad,
      NewsRequest? request}) {
    return NewsCommonState(
        openSearch: openSearch ?? this.openSearch,
        nameScreen: nameScreen ?? this.nameScreen,
        request: request ?? this.request,
        canLoad: canLoad ?? this.canLoad,
        status: status ?? this.status,
        listNews: listNews ?? this.listNews);
  }

  @override
  List<Object?> get props =>
      [status, canLoad, request, listNews, nameScreen, openSearch];
}
