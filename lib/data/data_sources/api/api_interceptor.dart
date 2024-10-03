import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:phu_tho_mobile/application/utils/navigation_utils.dart';
import 'package:phu_tho_mobile/data/data_sources/storage/shared_preferences/shared_preferences_helper.dart';
import 'package:phu_tho_mobile/di.dart';
import 'package:phu_tho_mobile/presentation/common_widgets/app_dialog.dart';
import 'package:phu_tho_mobile/presentation/routes/route_name.dart';

class ApiInterceptors extends InterceptorsWrapper {
  @override
  void onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    final loggedInfo = await getIt<SharedPreferencesHelper>().getLoggedInfo();

    if (loggedInfo?.isExpired == true) {
      getIt<SharedPreferencesHelper>().removeLoggedInfo();
      AppDialog.showDialogConfirm(NavigatorUtils.navigatorKey.currentContext!,
          label: "Phiên đăng nhập đã hết hạn, vui lòng đăng nhập lại",
          onConfirm: () {
        Navigator.of(NavigatorUtils.navigatorKey.currentContext!)
            .pushNamedAndRemoveUntil(RouteName.login, (route) => false);
      }, barrierDismissible: false);
    }

    if (loggedInfo?.accessToken.isNotEmpty == true) {
      options.headers['Authorization'] = 'Bearer ${loggedInfo?.accessToken}';
    }

    return super.onRequest(options, handler);
  }
}
