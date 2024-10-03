import 'package:bloc/bloc.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:phu_tho_mobile/application/enums/load_status.dart';
import 'package:phu_tho_mobile/di.dart';
import 'package:phu_tho_mobile/domain/models/request/news/news_request.dart';
import 'package:phu_tho_mobile/domain/repositories/news_repository.dart';
import 'package:phu_tho_mobile/presentation/screens/news_communication/communication_state.dart';

class CommunicationCubit extends Cubit<CommunicationState> {
  CommunicationCubit() : super(const CommunicationState());

  final repo = getIt.get<NewsRepository>();

  Future<void> getCommunication() async {
    try {
      emit(state.copyWith(status: LoadStatus.loading));
      final response = await repo.getNewCommunication(state.request);
      if (response.isRight) {
        emit(state.copyWith(
            status: LoadStatus.success,
            canLoad: response.right.hasNextPage,
            listNews: response.right.listItem));
        return;
      }
      emit(state.copyWith(status: LoadStatus.failure));
      return;
    } catch (e) {
      emit(state.copyWith(status: LoadStatus.failure));
      return;
    }
  }



  Future<void> getCommunicationLoadMore() async {
    if(state.canLoad){
      try {
        emit(state.copyWith(
            status: LoadStatus.loading,
            request:
            state.request.copyWith(pageIndex: state.request.pageIndex + 1)));
        final response = await repo.getNewCommunication(state.request);
        if (response.isRight) {
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
        int? pageSize,
      String? title,
        DateTime? timeFilter,
      DateTime? dayPost,
      DateTime? dayShow,
      DateTime? dayExpiration}) {
    emit(state.copyWith(
        request: state.request.copyWith(
            pageIndex: pageIndex,
            titleFilter: title,
            dateExpiration: formatDate(dayExpiration),
            pageSize: pageSize,
            timeFilter: formatDate(timeFilter),
            datePost: formatDate(dayPost),
            dateShow: formatDate(dayShow))));
  }

  String formatDate(DateTime? date){
    return date!= null ? DateFormat('dd/MM/yyyy').format(date) : '';
  }
}
