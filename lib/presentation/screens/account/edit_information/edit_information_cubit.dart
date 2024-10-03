import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:phu_tho_mobile/application/enums/load_status.dart';
import 'package:phu_tho_mobile/di.dart';
import 'package:phu_tho_mobile/domain/models/request/edit_information/edit_information_request.dart';
import 'package:phu_tho_mobile/domain/repositories/user_repository.dart';
import 'package:phu_tho_mobile/presentation/screens/account/edit_information/edit_infomation_state.dart';

class EditInformationCubit extends Cubit<EditInformationState> {
  EditInformationCubit() : super(const EditInformationState());

  final _repo = getIt.get<UserRepository>();

  void onChangeRequest(EditInformationRequest request) {
    emit(state.copyWith(request: request));
  }

  Future<void> updateInformation() async {
    try {
      emit(state.copyWith(loadStatus: LoadStatus.loading));
      final response = await _repo.updateInformationUser(state.request);
      if (response.isRight) {
        emit(state.copyWith(
            loadStatus: LoadStatus.success, message: response.right));
        return;
      }
      emit(state.copyWith(
          loadStatus: LoadStatus.failure, message: response.left));
    } catch (e) {
      emit(state.copyWith(
          loadStatus: LoadStatus.failure, message: e.toString()));
    }
  }
}
