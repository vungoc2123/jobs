import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:phu_tho_mobile/application/enums/load_status.dart';
import 'package:phu_tho_mobile/application/enums/type_action.dart';
import 'package:phu_tho_mobile/di.dart';
import 'package:phu_tho_mobile/domain/models/common/item_filter.dart';
import 'package:phu_tho_mobile/domain/models/request/business/business_request.dart';
import 'package:phu_tho_mobile/domain/models/response/filter_response/filter_response.dart';
import 'package:phu_tho_mobile/domain/repositories/business_repository.dart';
import 'package:phu_tho_mobile/domain/repositories/dict_item_repository.dart';
import 'package:phu_tho_mobile/presentation/screens/business/list_business/business_state.dart';

class BusinessCubit extends Cubit<BusinessState> {
  BusinessCubit() : super(const BusinessState());

  final _repo = getIt.get<BusinessRepository>();
  final _filterRepo = getIt.get<DictItemRepository>();

  Future<void> getBusiness() async {
    try {
      emit(state.copyWith(loadStatus: LoadStatus.loading));
      final response = await _repo.getBusiness(state.request, state.type);
      if (response.isRight) {
        emit(state.copyWith(
            loadStatus: LoadStatus.success,
            hasNextPage: response.right.hasNextPage,
            business: response.right.listItem));
        return;
      }
      emit(state.copyWith(loadStatus: LoadStatus.failure));
    } catch (e) {
      emit(state.copyWith(loadStatus: LoadStatus.failure));
    }
  }

  Future<void> getMoreBusiness() async {
    try {
      if (!state.hasNextPage || state.loadMoreStatus == LoadStatus.loading) {
        return;
      }
      emit(state.copyWith(loadMoreStatus: LoadStatus.loading));
      onChangeRequest(
          state.request.copyWith(pageIndex: state.request.pageIndex + 1));
      final response = await _repo.getBusiness(state.request, state.type);
      if (response.isRight) {
        emit(state.copyWith(
            loadMoreStatus: LoadStatus.success,
            hasNextPage: response.right.hasNextPage,
            business: [...state.business, ...response.right.listItem]));
        return;
      }
      emit(state.copyWith(loadMoreStatus: LoadStatus.failure));
    } catch (e) {
      emit(state.copyWith(loadMoreStatus: LoadStatus.failure));
    }
  }

  Future<void> deleteBusiness(int idBusiness) async {
    try {
      emit(state.copyWith(deleteStatus: LoadStatus.loading));
      final response = await _repo.deleteBusiness(idBusiness);
      if (response.isRight) {
        emit(state.copyWith(
            deleteStatus: LoadStatus.success, message: response.right));
        return;
      }
      emit(state.copyWith(
          deleteStatus: LoadStatus.failure, message: response.left));
    } catch (e) {
      emit(state.copyWith(
          deleteStatus: LoadStatus.failure, message: e.toString()));
    }
  }

  void onChangeRequest(BusinessRequest newRequest) {
    emit(state.copyWith(request: newRequest));
  }

  void onChangeFilterStatus(ItemFilter itemFilter) {
    emit(state.copyWith(
        filterResponse: FilterResponse(
            text: itemFilter.getTitle(), value: itemFilter.getValues())));
  }

  void changeTypeAction(TypeAction typeAction) {
    emit(state.copyWith(type: typeAction));
  }

  Future<void> getStatusBusiness() async {
    try {
      emit(state.copyWith(loadStatusBusiness: LoadStatus.loading));
      final response = await _filterRepo.getStatusBusiness();
      if (response.isRight) {
        emit(state.copyWith(
            loadStatusBusiness: LoadStatus.success,
            statusBusiness: response.right));
        return;
      }
      emit(state.copyWith(loadStatusBusiness: LoadStatus.failure));
    } catch (e) {
      emit(state.copyWith(loadStatusBusiness: LoadStatus.failure));
    }
  }
}
