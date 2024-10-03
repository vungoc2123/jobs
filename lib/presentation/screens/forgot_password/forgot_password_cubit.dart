import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:phu_tho_mobile/application/enums/load_status.dart';
import 'package:phu_tho_mobile/di.dart';
import 'package:phu_tho_mobile/domain/models/request/forgot_password/forgot_password_request.dart';
import 'package:phu_tho_mobile/domain/repositories/authentication_repository.dart';
import 'package:phu_tho_mobile/presentation/screens/forgot_password/forgot_password_state.dart';

class ForgotPasswordCubit extends Cubit<ForgotPasswordState> {
  ForgotPasswordCubit() : super(const ForgotPasswordState());

  final _repo = getIt.get<AuthenticationRepository>();

  Future<void> forgotPassword() async {
    try {
      emit(state.copyWith(loadStatus: LoadStatus.loading));
      final response = await _repo.forgotPassword(state.request);
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

  void onChangeRequest(ForgotPasswordRequest request) {
    emit(state.copyWith(request: request));
  }
}
