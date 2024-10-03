import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:phu_tho_mobile/application/enums/load_status.dart';
import 'package:phu_tho_mobile/application/enums/type_industrial_park.dart';
import 'package:phu_tho_mobile/di.dart';
import 'package:phu_tho_mobile/domain/models/request/industrial_park/industrial_park_request.dart';
import 'package:phu_tho_mobile/domain/models/response/industrial_park/industrial_park_response.dart';
import 'package:phu_tho_mobile/domain/repositories/industrial_park_repository.dart';
import 'package:phu_tho_mobile/presentation/screens/industria_park/list/bloc/industrial_park_state.dart';

class IndustrialParkCubit extends Cubit<IndustrialParkState> {
  IndustrialParkCubit() : super(const IndustrialParkState());
  final _repo = getIt.get<IndustrialParkRepository>();

  Future<void> getIndustrialParks(TypeIndustrialPark type) async {
    try {
      emit(state.copyWith(status: LoadStatus.loading));
      IndustrialParkRequest request = IndustrialParkRequest(
          name: state.request.name, location: state.request.location);
      final response = await _repo.getIndustrialParks(type, request);
      if (response.isRight) {
        return emit(state.copyWith(
            status: LoadStatus.success,
            industrialParks: response.right.listItem,
            request: request.copyWith(pageIndex: 2),
            hasNextPage: response.right.hasNextPage));
      }
      emit(state.copyWith(status: LoadStatus.failure));
    } catch (e) {
      emit(state.copyWith(status: LoadStatus.failure));
    }
  }

  Future<void> getIndustrialParksMore(TypeIndustrialPark type) async {
    try {
      if (!state.hasNextPage) return;
      emit(state.copyWith(statusMore: LoadStatus.loading));
      IndustrialParkRequest request = state.request;
      final response = await _repo.getIndustrialParks(type, request);
      if (response.isRight) {
        List<IndustrialParkResponse> industrialParks = [
          ...state.industrialParks,
          ...response.right.listItem
        ];
        return emit(state.copyWith(
            industrialParks: industrialParks,
            statusMore: LoadStatus.success,
            request: IndustrialParkRequest(
                pageIndex: state.request.pageIndex + 1,
                name: state.request.name,
                location: state.request.location),
            hasNextPage: response.right.hasNextPage));
      }
      emit(state.copyWith(statusMore: LoadStatus.failure));
    } catch (e) {
      emit(state.copyWith(statusMore: LoadStatus.failure));
    }
  }

  Future<void> deleteIndustrialPark(int id) async {
    try {
      emit(state.copyWith(statusDelete: LoadStatus.loading));
      final response = await _repo.deleteIndustrialPark(id);
      if (response.isRight) {
        return emit(state.copyWith(
          statusDelete: LoadStatus.success,
        ));
      }
      emit(state.copyWith(statusDelete: LoadStatus.failure));
    } catch (e) {
      emit(state.copyWith(statusDelete: LoadStatus.failure));
    }
  }

  void changeSearchBy(String value) {
    emit(state.copyWith(searchBy: value));
  }

  void changeVisible(bool value) {
    emit(state.copyWith(isShowSearch: value));
  }

  void changeRequest(
      {String? name, String? location, int? pageSize, int? pageIndex}) {
    emit(state.copyWith(
        request: state.request.copyWith(
            name: name,
            location: location,
            pageSize: pageSize,
            pageIndex: pageIndex)));
  }
}
