import 'package:bloc/bloc.dart';
import 'package:phu_tho_mobile/application/enums/load_status.dart';
import 'package:phu_tho_mobile/di.dart';
import 'package:phu_tho_mobile/domain/repositories/service_repository.dart';
import 'package:phu_tho_mobile/presentation/screens/situation/situation_state.dart';

class SituationCubit extends Cubit<SituationState> {
  SituationCubit() : super(const SituationState());
  final repo = getIt.get<ServiceRepository>();

  Future<void> getSituation() async {
    try {
      emit(state.copyWith(status: LoadStatus.loading));
      final response = await repo.getBusinessService(state.request);
      if (response.isRight) {
        emit(state.copyWith(
            status: LoadStatus.success,
            hadNextPage: response.right.hasNextPage,
            listData: response.right.listItem));
        return;
      }
      emit(state.copyWith(status: LoadStatus.failure));
    } catch (e) {
      emit(state.copyWith(status: LoadStatus.failure));
    }
  }

  Future<void> getSituationMore() async {
    if (state.hadNextPage) {
      try {
        emit(state.copyWith(
            status: LoadStatus.loading,
            request: state.request
                .copyWith(pageIndex: state.request.pageIndex + 1)));
        final response = await repo.getBusinessService(state.request);
        if (response.isRight) {
          emit(state.copyWith(
              status: LoadStatus.success,
              hadNextPage: response.right.hasNextPage,
              listData: [...response.right.listItem, ...state.listData]));
          return;
        }
        emit(state.copyWith(status: LoadStatus.failure));
      } catch (e) {
        emit(state.copyWith(status: LoadStatus.failure));
      }
    }
  }

  void openSearch(int field){
    emit(state.copyWith(openSearch: !state.openSearch, searchField: field));
  }

  void changeRequest(
      {int? pageIndex,
      String? nameBusiness,
      String? taxCode,
      String? address}) {
    emit(state.copyWith(
        request: state.request.copyWith(
            pageIndex: pageIndex,
            nameBusiness: nameBusiness,
            taxCode: taxCode,
            address: address)));
  }
}
