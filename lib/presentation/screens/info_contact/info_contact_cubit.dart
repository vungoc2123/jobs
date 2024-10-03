import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:phu_tho_mobile/application/enums/load_status.dart';
import 'package:phu_tho_mobile/di.dart';
import 'package:phu_tho_mobile/domain/repositories/utilities_repository.dart';
import 'package:phu_tho_mobile/presentation/screens/info_contact/info_contact_state.dart';

class InfoContactCubit extends Cubit<InfoContactState> {
  InfoContactCubit() : super(const InfoContactState());

  final _repo = getIt.get<UtilitiesRepository>();

  Future<void> getInfoContact() async {
    try {
      emit(state.copyWith(loadStatus: LoadStatus.loading));
      final response = await _repo.getInfoContact();
      if (response.isRight) {
        emit(state.copyWith(
            loadStatus: LoadStatus.success,
            infoContactResponse: response.right));
        return;
      }
      emit(state.copyWith(loadStatus: LoadStatus.failure));
    } catch (e) {
      emit(state.copyWith(loadStatus: LoadStatus.failure));
    }
  }
}
