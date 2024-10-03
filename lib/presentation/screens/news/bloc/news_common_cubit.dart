import 'package:bloc/bloc.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:either_dart/either.dart';
import 'package:phu_tho_mobile/application/enums/load_status.dart';
import 'package:phu_tho_mobile/application/enums/path_news.dart';
import 'package:phu_tho_mobile/data/data_sources/api/api_response.dart';
import 'package:phu_tho_mobile/di.dart';
import 'package:phu_tho_mobile/domain/models/response/news/news_response.dart';
import 'package:phu_tho_mobile/domain/repositories/news_repository.dart';
import 'package:phu_tho_mobile/presentation/screens/news/bloc/news_common_state.dart';

import '../../../../domain/models/request/news/news_request.dart';

class NewsCommonCubit extends Cubit<NewsCommonState> {
  NewsCommonCubit() : super(const NewsCommonState());

  final repo = getIt.get<NewsRepository>();

  void getNameScreen({required NewsPath nameScreen}){
    emit(state.copyWith(nameScreen: nameScreen));
  }

  Future<Either<String, ListDataResponse<NewsResponse>>> getPath({required NewsPath nameScreen}) async {
    switch (nameScreen) {
      case NewsPath.advise:
        return await repo.getNewsAdvise(state.request);
      case NewsPath.findingPeople:
        return await repo.getNewsFindingPeople(state.request);
      case NewsPath.introduction:
        return await repo.getNewsIntroduction(state.request);
      case NewsPath.jobSeekers:
        return await repo.getNewsJobSeekers(state.request);
      case NewsPath.supply:
        return await repo.getNewsSupply(state.request);
      case NewsPath.employmentStatus:
        return await repo.getNewsEmploymentStatus(state.request);
      case NewsPath.forecast:
        return await repo.getForecast(state.request);
      default:
        return const Left("Invalid NewsPath");
    }
  }

  Future<void> getNews() async {
    try{
      emit(state.copyWith(status: LoadStatus.loading));

      final result = await getPath(nameScreen: state.nameScreen);

      result.fold(
              (error) => emit(state.copyWith(status: LoadStatus.failure)),
              (response) => emit(state.copyWith(
              status: LoadStatus.success,
              canLoad: response.hasNextPage,
              listNews: response.listItem
          ))
      );
    }catch (e){
      emit(state.copyWith(status: LoadStatus.failure));
    }
  }


  Future<void> getNewsMore() async {
    if(state.canLoad){
      try {
        emit(state.copyWith(
            status: LoadStatus.loading,
            request:
            state.request.copyWith(pageIndex: state.request.pageIndex + 1)));
        final response = await getPath(nameScreen: state.nameScreen);
        if (response is ListDataResponse<NewsResponse>) {
          emit(state.copyWith(
              status: LoadStatus.success,
              canLoad: response.right.hasNextPage,
              listNews: [...state.listNews, ...response.right.listItem]));
          return;
        }
        emit(state.copyWith(status: LoadStatus.failure));
      } catch (e) {
        emit(state.copyWith(status: LoadStatus.failure));
        return;
      }
    }
  }


  void openSearch(){
    emit(state.copyWith(openSearch: !state.openSearch,));
  }

  void resetRequest(){
    emit(state.copyWith(request: const NewsRequest()));
  }

  void changeRequest(
      {int? pageIndex,
        DateTime? timeFilter,
        int? pageSize,
        String? title,
        DateTime? dayPost,
        DateTime? dayShow,
        DateTime? dayExpiration}) {
    emit(state.copyWith(
        request: state.request.copyWith(
            pageIndex: pageIndex,
            titleFilter: title,
            timeFilter: formatDate(timeFilter),
            dateExpiration: formatDate(dayExpiration),
            pageSize: pageSize,
            datePost: formatDate(dayPost),
            dateShow: formatDate(dayShow))));
  }

  String formatDate(DateTime? date){
    return date!= null ? DateFormat('dd/MM/yyyy').format(date) : '';
  }
}
