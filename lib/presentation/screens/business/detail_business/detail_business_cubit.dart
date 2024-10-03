import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:phu_tho_mobile/application/enums/load_status.dart';
import 'package:phu_tho_mobile/application/enums/type_action.dart';
import 'package:phu_tho_mobile/di.dart';
import 'package:phu_tho_mobile/domain/repositories/business_repository.dart';
import 'package:phu_tho_mobile/presentation/screens/business/detail_business/detail_business_state.dart';

class DetailBusinessCubit extends Cubit<DetailBusinessState> {
  DetailBusinessCubit() : super(const DetailBusinessState());

  final _repo = getIt.get<BusinessRepository>();

  Future<void> getDetailBusiness(int businessId) async {
    try {
      emit(state.copyWith(loadStatus: LoadStatus.loading));
      final response = await _repo.getDetailBusiness(businessId, state.type);
      if (response.isRight) {
        emit(state.copyWith(
            loadStatus: LoadStatus.success, businessResponse: response.right));
        return;
      }
      emit(state.copyWith(loadStatus: LoadStatus.failure));
    } catch (e) {
      emit(state.copyWith(loadStatus: LoadStatus.failure));
    }
  }

  void changeTypeAction(TypeAction type){
    emit(state.copyWith(type: type));
  }
}
