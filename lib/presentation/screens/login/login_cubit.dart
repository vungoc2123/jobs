import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:phu_tho_mobile/application/dto/logger_info_model.dart';
import 'package:phu_tho_mobile/application/enums/load_status.dart';
import 'package:phu_tho_mobile/data/data_sources/storage/shared_preferences/shared_preferences_helper.dart';
import 'package:phu_tho_mobile/di.dart';
import 'package:phu_tho_mobile/domain/models/request/login_request/login_request.dart';
import 'package:phu_tho_mobile/domain/repositories/authentication_repository.dart';

import 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(const LoginState());

  final _repo = getIt.get<AuthenticationRepository>();
  final sharedPreferencesHelper = getIt.get<SharedPreferencesHelper>();

  Future<void> login() async {
    try {
      emit(state.copyWith(loadStatus: LoadStatus.loading));
      final response = await _repo.login(state.loginRequest);
      if (response.isRight && response.right.data != null) {
        final loggedInfo = LoggerInfoModel(
          accountId: response.right.data!.accountInfo.id,
          expireTime: DateTime.parse(response.right.data!.timeoutToken),
          accessToken: response.right.data!.token,
        );
        await sharedPreferencesHelper.setLoggerInfo(loggedInfo);

        emit(state.copyWith(loadStatus: LoadStatus.success, message: response.right.message));
        return;
      }
      emit(state.copyWith(loadStatus: LoadStatus.failure, message: response.left));
    } catch (e) {
      emit(state.copyWith(loadStatus: LoadStatus.failure, message: e.toString()));
    }
  }

  void changeLoginRequest(LoginRequest loginRequest) {
    emit(state.copyWith(loginRequest: loginRequest));
  }
}
