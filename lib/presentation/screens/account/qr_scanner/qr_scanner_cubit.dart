import 'package:bloc/bloc.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:equatable/equatable.dart';
import 'package:phu_tho_mobile/application/enums/load_status.dart';
import 'package:phu_tho_mobile/data/data_sources/storage/shared_preferences/shared_preferences_helper.dart';
import 'package:phu_tho_mobile/di.dart';
import 'package:phu_tho_mobile/domain/models/request/validate_account_by_qr/validate_account_by_qr_request.dart';
import 'package:phu_tho_mobile/domain/repositories/authentication_repository.dart';

part 'qr_scanner_state.dart';

class QrScannerCubit extends Cubit<QrScannerState> {
  QrScannerCubit() : super(const QrScannerState());

  Future<void> validateAccountByQrCode() async {
    try {
      if(state.qrCode.isEmpty) return;

      emit(state.copyWith(loadStatus: LoadStatus.loading));

      final loggedInfo = await getIt<SharedPreferencesHelper>().getLoggedInfo();
      final request = ValidateAccountByQrRequest(
        token: loggedInfo?.accessToken ?? '',
        qrCode: state.qrCode,
      );
      final response = await getIt<AuthenticationRepository>().validateAccountByQr(request);

      if (response.isRight) {
        emit(state.copyWith(loadStatus: LoadStatus.success, message: response.right));
        await resetQrCode();
        return;
      }

      emit(state.copyWith(loadStatus: LoadStatus.failure, message: response.left));
      await resetQrCode();
    } catch (e) {
      emit(state.copyWith(loadStatus: LoadStatus.success, message: tr('commonErrorMessage')));
      await resetQrCode();
    }
  }

  Future<void> resetQrCode() async {
    await Future.delayed(const Duration(seconds: 1));
    onChangeQrCode('');
  }

  void onChangeQrCode(String code) {
    emit(state.copyWith(qrCode: code));
  }
}
