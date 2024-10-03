import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:phu_tho_mobile/application/enums/load_status.dart';
import 'package:phu_tho_mobile/di.dart';
import 'package:phu_tho_mobile/domain/repositories/household_repository.dart';
import 'package:phu_tho_mobile/presentation/screens/member_household/detail_member_household/detail_member_state.dart';

class DetailMemberCubit extends Cubit<DetailMemberState> {
  DetailMemberCubit() : super(const DetailMemberState());
  final _repo = getIt.get<HouseholdRepository>();

  Future<void> getDetailMember(int id) async {
    try {
      emit(state.copyWith(loadStatus: LoadStatus.loading));
      final response = await _repo.getDetailMember(id);
      if (response.isRight) {
        emit(state.copyWith(
            loadStatus: LoadStatus.success, member: response.right));
        return;
      }
      emit(state.copyWith(loadStatus: LoadStatus.failure));
    } catch (e) {
      emit(state.copyWith(loadStatus: LoadStatus.failure));
    }
  }
}
