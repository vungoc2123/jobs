import 'package:bloc/bloc.dart';
import 'package:phu_tho_mobile/application/enums/load_status.dart';
import 'package:phu_tho_mobile/di.dart';
import 'package:phu_tho_mobile/domain/models/request/economic_activity/economic_activity_request.dart';
import 'package:phu_tho_mobile/domain/models/response/ecocomic_activity/economic_activity_response.dart';
import 'package:phu_tho_mobile/domain/repositories/dict_item_repository.dart';
import 'package:phu_tho_mobile/domain/repositories/economic_activity_repository.dart';
import 'package:phu_tho_mobile/presentation/screens/economic_activity/bloc/economic_state.dart';
import 'package:phu_tho_mobile/application/extentions/string_extension.dart';

class EconomicCubit extends Cubit<EconomicState> {
  EconomicCubit() : super(const EconomicState());

  final _repo = getIt.get<EconomicActivityRepository>();
  final filterRepo = getIt.get<DictItemRepository>();

  Future<void> getEconomics() async {
    try {
      emit(state.copyWith(status: LoadStatus.loading));
      EconomicActivityRequest request = state.request.copyWith(pageIndex: 1);
      final response = await _repo.getEconomicActivity(request.copyWith(
          timeStart: request.timeStart?.formatToY(),
          timeEnd: request.timeEnd?.formatToY()));
      if (response.isRight) {
        return emit(state.copyWith(
            status: LoadStatus.success,
            economics: response.right.listItem,
            request: request.copyWith(pageIndex: 2),
            hasNextPage: response.right.hasNextPage));
      }
      emit(state.copyWith(status: LoadStatus.failure));
    } catch (e) {
      emit(state.copyWith(status: LoadStatus.failure));
    }
  }

  Future<void> getEconomicsMore() async {
    try {
      if (!state.hasNextPage) return;
      emit(state.copyWith(statusMore: LoadStatus.loading));
      EconomicActivityRequest request = state.request;
      final response = await _repo.getEconomicActivity(request);
      if (response.isRight) {
        List<EconomicActivityResponse> economics = [
          ...state.economics,
          ...response.right.listItem
        ];
        return emit(state.copyWith(
            economics: economics,
            statusMore: LoadStatus.success,
            request:
                state.request.copyWith(pageIndex: state.request.pageIndex + 1),
            hasNextPage: response.right.hasNextPage));
      }
      emit(state.copyWith(statusMore: LoadStatus.failure));
    } catch (e) {
      emit(state.copyWith(statusMore: LoadStatus.failure));
    }
  }

  Future<void> getAllFilter() async {
    try {
      final listTypeWork = await filterRepo.getTypeWork();
      final listTypeEconomic = await filterRepo.getTypeEconomic();
      emit(state.copyWith(listTypeWork: [
        ...state.listTypeWork,
        ...listTypeWork.right
      ], listTypeEconomic: [
        ...state.listTypeEconomic,
        ...listTypeEconomic.right
      ]));
    } catch (e) {
      print(e.toString());
    }
  }

  void changeSearchBy(String value) {
    emit(state.copyWith(searchBy: value));
  }

  void changeVisible(bool value) {
    emit(state.copyWith(isShowSearch: value));
  }

  void changeTitleFilter({String? typeWork, String? typeEconomic}) {
    emit(state.copyWith(typeWork: typeWork, typeEconomic: typeEconomic));
  }

  void changeRequest(
      {
      String? location,
      String? position,
      String? timeStart,
      String? timeEnd,
      pageSize,
      int? pageIndex,
      String? typeWork,
      String? typeEconomic,
      bool reset = false}) {
    if (reset) {
      return emit(state.copyWith(
          request: const EconomicActivityRequest(),
          typeEconomic: '',
          typeWork: ''));
    }
    emit(state.copyWith(
        request: state.request.copyWith(
            location: location,
            position: position,
            timeStart: timeStart,
            timeEnd: timeEnd,
            pageSize: pageSize,
            typeWork: typeWork,
            typeEconomic: typeEconomic,
            pageIndex: pageIndex)));
  }
}
