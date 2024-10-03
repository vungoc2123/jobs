import 'dart:convert';

import 'package:phu_tho_mobile/application/dto/logger_info_model.dart';
import 'package:phu_tho_mobile/application/enums/storages_key.dart';
import 'package:phu_tho_mobile/data/data_sources/storage/shared_preferences/base_shared_preferences.dart';

class SharedPreferencesHelper extends BaseSharedPreferences {
  Future<void> setLoggerInfo(LoggerInfoModel loggerInfo) async {
    await super.setStringValue(StoragesKey.loggedInfo, json.encode(loggerInfo));
  }

  Future<LoggerInfoModel?> getLoggedInfo() async {
    try {
      final data = await super.getStringValue(StoragesKey.loggedInfo);
      if (data.isNotEmpty) {
        return LoggerInfoModel.fromJson(json.decode(data));
      }
      return null;
    } catch (e) {
      return null;
    }
  }

  Future<void> removeLoggedInfo() async {
    await super.removeByKey(StoragesKey.loggedInfo);
  }
}
