import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:phu_tho_mobile/application/enums/load_status.dart';
import 'package:phu_tho_mobile/data/data_sources/storage/shared_preferences/shared_preferences_helper.dart';
import 'package:phu_tho_mobile/di.dart';
import 'package:phu_tho_mobile/domain/repositories/user_repository.dart';
import 'package:phu_tho_mobile/presentation/screens/account/infomation_account/infomation_account_state.dart';

import '../../../../data/data_sources/api/api_client.dart';
import '../../../../data/data_sources/api/api_client_provider.dart';

class InformationAccountCubit extends Cubit<InformationAccountState> {
  InformationAccountCubit() : super(const InformationAccountState());
  final _userRepository = getIt.get<UserRepository>();
  final _sharedPreference = getIt.get<SharedPreferencesHelper>();
  final ApiClient _apiClient = getIt<ApiClient>();
  CancelToken? _cancelToken;

  Future<void> getUserProfile() async {
    try {
      emit(state.copyWith(loadStatus: LoadStatus.loading));
      final loggedInfo = await _sharedPreference.getLoggedInfo();
      if (loggedInfo != null) {
        final response =
            await _userRepository.getUserProfile(loggedInfo.accountId);

        if (response.isRight) {
          emit(state.copyWith(
            loadStatus: LoadStatus.success,
            userProfile: response.right.data,
          ));
          print("emit success");
          return;
        }
      }
      emit(state.copyWith(loadStatus: LoadStatus.failure));
    } catch (e) {
      emit(state.copyWith(loadStatus: LoadStatus.failure));
    }
  }

  Future<void> deleteAccount() async {
    try {
      emit(state.copyWith(deleteStatus: LoadStatus.loading));
      final response =
          await _userRepository.deleteAccount(state.userProfile.id);
      if (response.isRight) {
        await _sharedPreference.removeLoggedInfo();
        emit(state.copyWith(
            deleteStatus: LoadStatus.success, message: response.right.isEmpty ? "Xóa tài khoản thành công" : response.right));
        return;
      }
      emit(state.copyWith(
          deleteStatus: LoadStatus.failure,
          message: response.left.isEmpty
              ? "Không xóa tài khoản được"
              : response.left));
    } catch (e) {
      emit(state.copyWith(
          deleteStatus: LoadStatus.failure, message: e.toString()));
    }
  }

  void cancelDeleteOperation() {
    if (_cancelToken != null) {
      ApiClientProvider.cancelRequest(_cancelToken!);
      _cancelToken = null;
    }
    emit(state.copyWith(deleteStatus: LoadStatus.initial));
  }
}
