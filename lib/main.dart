import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:phu_tho_mobile/application/configs/env_configs.dart';
import 'package:phu_tho_mobile/data/data_sources/api/api_client_provider.dart';
import 'package:phu_tho_mobile/data/data_sources/api/global_http_override.dart';
import 'package:phu_tho_mobile/presentation/screens/app.dart';

import 'di.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  configureDependencies(); // init DI
  await EasyLocalization.ensureInitialized(); // init localization

  await EnvConfigs.init();

  ApiClientProvider.init(); // init api client
  HttpOverrides.global = GlobalHttpOverrides();

  runApp(EasyLocalization(
    supportedLocales: const [Locale('en', 'US'), Locale('vi', 'VN')],
    path: 'assets/translations',
    fallbackLocale: const Locale('vi', 'VN'),
    startLocale: const Locale('vi', 'VN'),
    child: const MyApp(),
  ));
}
