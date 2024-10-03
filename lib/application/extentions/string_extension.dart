import 'package:phu_tho_mobile/application/configs/env_configs.dart';
import 'package:phu_tho_mobile/application/extentions/datetime_extension.dart';
import 'package:phu_tho_mobile/data/data_sources/storage/shared_preferences/shared_preferences_helper.dart';

import '../../di.dart';

extension StringExtention on String {
  String formatToDMY() {
    DateTime? dateTime = DateTime.tryParse(this);
    if (dateTime == null) return '';
    return dateTime.formatToDMY();
  }

  String formatToHSDMY() {
    DateTime? dateTime = DateTime.tryParse(this);
    if (dateTime == null) return '';
    return dateTime.formatToHSDMY();
  }

  String formatToY() {
    DateTime? dateTime = DateTime.tryParse(this);
    if (dateTime == null) return '';
    return dateTime.formatToY();
  }

  String toResourceUrl() {
    String link = trim();
    String join = link.startsWith('/') ? "" : "/";
    if (!link.contains("://")) {
      link = "${EnvConfigs.resourceUrl}$join$link";
    }
    return link;
  }

  Future<String> withUserToken() async {
    final loggedInfo = await getIt<SharedPreferencesHelper>().getLoggedInfo();
    if (loggedInfo != null) {
      return "$this?token=${loggedInfo.accessToken}";
    }
    return this;
  }

  String withParam(Map<String, dynamic> params) {
    String queryString = "";
    params.forEach((key, value) {
      queryString += "&$key=${value.toString()}";
    });
    return "$this$queryString";
  }
}
