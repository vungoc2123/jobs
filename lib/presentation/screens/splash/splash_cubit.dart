import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:phu_tho_mobile/application/enums/load_status.dart';
import 'package:phu_tho_mobile/data/data_sources/storage/shared_preferences/shared_preferences_helper.dart';
import 'package:phu_tho_mobile/di.dart';

import 'splash_state.dart';

class SplashCubit extends Cubit<SplashSate> {
  SplashCubit() : super(const SplashSate());

  final sharePreferences = getIt<SharedPreferencesHelper>();

  Future<void> checkLoggedSessionBeforeImplement() async {
    try {
      emit(state.copyWith(loadStatus: LoadStatus.loading));
      final loggedInfo = await sharePreferences.getLoggedInfo();
      if (loggedInfo?.isExpired == true) {
        await sharePreferences.removeLoggedInfo();
      }
    } catch (e) {
      debugPrint('checkLoggedSessionBeforeImplement error $e');
    } finally {
      await Future.delayed(const Duration(seconds: 2));
      emit(state.copyWith(loadStatus: LoadStatus.success));
    }
  }
}
