import 'package:bloc/bloc.dart';
import 'package:phu_tho_mobile/application/enums/load_status.dart';
import 'package:phu_tho_mobile/application/enums/type_action.dart';
import 'package:phu_tho_mobile/di.dart';
import 'package:phu_tho_mobile/domain/models/request/business/business_request.dart';
import 'package:phu_tho_mobile/domain/repositories/business_repository.dart';
import 'package:phu_tho_mobile/presentation/screens/industria_park/detail/bloc/detail_industrial_park_state.dart';

class DetailIndustrialParkCubit extends Cubit<DetailIndustrialParkState> {
  DetailIndustrialParkCubit() : super(const DetailIndustrialParkState());
  final _repo = getIt.get<BusinessRepository>();

  Future<void> getBusiness() async {
    try {
      emit(state.copyWith(loadStatus: LoadStatus.loading));
      final response = await _repo.getBusinessByIdIndustrialPark(state.request);
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
      final response = await _repo.getBusinessByIdIndustrialPark(state.request);
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

  void onChangeRequest(BusinessRequest newRequest) {
    emit(state.copyWith(request: newRequest));
  }
}
