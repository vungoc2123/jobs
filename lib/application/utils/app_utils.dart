import 'dart:io';

import 'package:flutter/material.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:phu_tho_mobile/application/configs/env_configs.dart';
import 'package:phu_tho_mobile/data/data_sources/storage/shared_preferences/shared_preferences_helper.dart';
import 'package:phu_tho_mobile/di.dart';
import 'package:phu_tho_mobile/presentation/routes/route_name.dart';
import 'package:http/http.dart' as http;

class AppUtils {
  static void dismissKeyboard() {
    FocusManager.instance.primaryFocus?.unfocus();
  }

  static Future<void> checkTokenBeforeImplement(BuildContext context,
      {required Function onPress}) async {
    final loggedInfo = await getIt<SharedPreferencesHelper>().getLoggedInfo();

    if (loggedInfo != null) {
      onPress.call();
      return;
    }
    if (!context.mounted) return;
    Navigator.of(context).pushNamed(RouteName.login);
  }

  static Future<void> openFile(File file, BuildContext context) async {
    try {
      final result = await OpenFile.open(file.path, linuxByProcess: true);
      if (result.type != ResultType.done) {
        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text("Không thể mở file: ${result.message}")),
          );
        }
      }
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Không thể mở file open")),
        );
      }
    }
  }

  static Future<void> downloadFile(String fileUrl, BuildContext context) async {
    try {
      final response = await http.get(Uri.parse(fileUrl));
      if (response.statusCode == 200) {
        final bytes = response.bodyBytes;
        Directory? directory;
        if (Platform.isAndroid) {
          directory = await getExternalStorageDirectory();
        }
        if (Platform.isIOS) {
          directory = await getLibraryDirectory();
        }
        final fileName =fileUrl.split("\\").last;
        final file = File('${directory?.absolute.path}/$fileName');
        await file.writeAsBytes(bytes);
        if (context.mounted) await openFile(file, context);
      }
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Không tải được file dowload!")),
        );
      }
    }
  }

  static getPath(String url) {
    if (url.isNotEmpty && url[0] != '/') {
      return '${EnvConfigs.resourceUrl}/$url';
    }
    return "${EnvConfigs.resourceUrl}$url";
  }
}
