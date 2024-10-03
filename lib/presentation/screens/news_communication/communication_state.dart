import 'package:equatable/equatable.dart';
import 'package:phu_tho_mobile/application/enums/load_status.dart';
import 'package:phu_tho_mobile/domain/models/request/news/news_request.dart';
import 'package:phu_tho_mobile/domain/models/response/news/news_response.dart';

class CommunicationState extends Equatable {
  final LoadStatus status;
  final List<NewsResponse> listNews;
  final List<NewsResponse> sameList;

  final bool canLoad;
  final NewsRequest request;

  final bool openSearch;

  const CommunicationState(
      {this.request = const NewsRequest(),
      this.openSearch = false,
      this.sameList = const [],
      this.canLoad = false,
      this.status = LoadStatus.initial,
      this.listNews = const []});

  CommunicationState copyWith(
      {LoadStatus? status,
      bool? openSearch,
      List<NewsResponse>? listNews,
      List<NewsResponse>? sameList,
      bool? canLoad,
      NewsRequest? request}) {
    return CommunicationState(
        openSearch: openSearch ?? this.openSearch,
        request: request ?? this.request,
        canLoad: canLoad ?? this.canLoad,
        sameList: sameList ?? this.sameList,
        status: status ?? this.status,
        listNews: listNews ?? this.listNews);
  }

  @override
  List<Object?> get props =>
      [status, canLoad, request, listNews, sameList, openSearch];
}
