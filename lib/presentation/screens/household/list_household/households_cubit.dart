import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:phu_tho_mobile/application/enums/load_status.dart';
import 'package:phu_tho_mobile/di.dart';
import 'package:phu_tho_mobile/domain/models/common/item_filter.dart';
import 'package:phu_tho_mobile/domain/models/request/household/household_request.dart';
import 'package:phu_tho_mobile/domain/models/response/filter_response/filter_response.dart';
import 'package:phu_tho_mobile/domain/repositories/dict_item_repository.dart';
import 'package:phu_tho_mobile/domain/repositories/household_repository.dart';
import 'package:phu_tho_mobile/presentation/screens/household/list_household/list_household_state.dart';

class HouseholdsCubit extends Cubit<HouseHoldsState> {
  HouseholdsCubit() : super(const HouseHoldsState());

  final _repo = getIt.get<HouseholdRepository>();
  final _filterRepo = getIt.get<DictItemRepository>();

  Future<void> getHouseholds() async {
    try {
      emit(state.copyWith(loadStatus: LoadStatus.loading));
      final response = await _repo.getHouseholds(state.request);
      if (response.isRight) {
        emit(state.copyWith(
            loadStatus: LoadStatus.success,
            households: response.right.listItem,
            hasNextPage: response.right.hasNextPage));
        return;
      }
      emit(state.copyWith(loadStatus: LoadStatus.failure));
    } catch (e) {
      emit(state.copyWith(loadStatus: LoadStatus.failure));
    }
  }

  void onChangeFilterArea(ItemFilter itemFilter) {
    emit(state.copyWith(
        filterResponseArea: FilterResponse(
            text: itemFilter.getTitle(), value: itemFilter.getValues())));
  }

  void onChangeFilterDistrict(ItemFilter itemFilter) {
    emit(state.copyWith(
        filterResponseDistrict: FilterResponse(
            text: itemFilter.getTitle(), value: itemFilter.getValues())));
  }

  void onChangeFilterCommune(ItemFilter itemFilter) {
    emit(state.copyWith(
        filterResponseCommunes: FilterResponse(
            text: itemFilter.getTitle(), value: itemFilter.getValues())));
  }

  Future<void> getMoreHouseholds() async {
    try {
      if (!state.hasNextPage || state.loadMoreStatus == LoadStatus.loading) {
        return;
      }
      emit(state.copyWith(loadMoreStatus: LoadStatus.loading));
      onChangeRequest(
          state.request.copyWith(pageIndex: state.request.pageIndex + 1));
      final response = await _repo.getHouseholds(state.request);
      if (response.isRight) {
        emit(state.copyWith(
            loadMoreStatus: LoadStatus.success,
            households: [...state.households, ...response.right.listItem],
            hasNextPage: response.right.hasNextPage));
        return;
      }
      emit(state.copyWith(loadMoreStatus: LoadStatus.failure));
    } catch (e) {
      emit(state.copyWith(loadMoreStatus: LoadStatus.failure));
    }
  }

  void onChangeRequest(HouseholdRequest newRequest) {
    emit(state.copyWith(request: newRequest));
  }

  Future<void> getAreas() async {
    try {
      emit(state.copyWith(loadAreas: LoadStatus.loading));
      final response = await _filterRepo.getAreas();
      if (response.isRight) {
        emit(state.copyWith(
            loadAreas: LoadStatus.success, areas: response.right));
        return;
      }
      emit(state.copyWith(loadAreas: LoadStatus.failure));
    } catch (e) {
      emit(state.copyWith(loadAreas: LoadStatus.failure));
    }
  }

  Future<void> getDistricts() async {
    try {
      emit(state.copyWith(loadDistrictStatus: LoadStatus.loading));
      final response = await _filterRepo.getDistrict('25');
      if (response.isRight) {
        emit(state.copyWith(
            loadDistrictStatus: LoadStatus.success, districts: response.right));
        return;
      }
      emit(state.copyWith(loadDistrictStatus: LoadStatus.failure));
    } catch (e) {
      emit(state.copyWith(loadDistrictStatus: LoadStatus.failure));
    }
  }

  Future<void> getCommunes(String idDistrict) async {
    try {
      emit(state.copyWith(loadCommuneStatus: LoadStatus.loading));
      final response = await _filterRepo.getCommune(idDistrict);
      if (response.isRight) {
        emit(state.copyWith(
            loadCommuneStatus: LoadStatus.success, communes: response.right));
        return;
      }
      emit(state.copyWith(loadCommuneStatus: LoadStatus.failure));
    } catch (e) {
      emit(state.copyWith(loadCommuneStatus: LoadStatus.failure));
    }
  }
}
