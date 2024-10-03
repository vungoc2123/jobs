import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:phu_tho_mobile/application/enums/load_status.dart';
import 'package:phu_tho_mobile/data/data_sources/storage/shared_preferences/shared_preferences_helper.dart';
import 'package:phu_tho_mobile/di.dart';
import 'package:phu_tho_mobile/domain/models/request/change_password/change_password_request.dart';
import 'package:phu_tho_mobile/domain/repositories/authentication_repository.dart';
import 'package:phu_tho_mobile/presentation/screens/account/change_password/change_password_state.dart';

class ChangePasswordCubit extends Cubit<ChangePasswordState> {
  ChangePasswordCubit() : super(const ChangePasswordState());

  final _repo = getIt.get<AuthenticationRepository>();
  final _sharedPreference = getIt.get<SharedPreferencesHelper>();

  Future<void> changePassword() async {
    try {
      emit(state.copyWith(loadStatus: LoadStatus.loading));
      if (checkRequest()) {
        final response = await _repo.changePassword(state.request);
        if (response.isRight) {
          emit(state.copyWith(
              loadStatus: LoadStatus.success, message: response.right));
          return;
        }
        emit(state.copyWith(
            loadStatus: LoadStatus.failure, message: response.left));
      }
    } catch (e) {
      emit(state.copyWith(loadStatus: LoadStatus.failure));
    }
  }

  void onChangeRequest(ChangePasswordRequest request) {
    emit(state.copyWith(request: request));
  }

  bool checkRequest() {
    if (state.request.oldPassword.trim() == "" ||
        state.request.newPassword.trim() == "" ||
        state.request.confirmPassword == "") {
      emit(state.copyWith(
          loadStatus: LoadStatus.failure,
          message: "Bạn cần điền đầy đủ thông tin"));
      return false;
    }
    if (state.request.newPassword.trim() !=
        state.request.confirmPassword.trim()) {
      emit(state.copyWith(
          loadStatus: LoadStatus.failure,
          message: "Mật khẩu mới và xác nhận mật khẩu không giống"));
      return false;
    }
    return true;
  }
  Future<void> logout() async {
    _sharedPreference.removeLoggedInfo();
  }
}
