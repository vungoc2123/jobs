import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:package_info_plus/package_info_plus.dart';

class EnvConfigs {
  static final String baseUrl = dotenv.get('BASE_URL', fallback: '');
  static final String resourceUrl = dotenv.get('RESOURCE_URL', fallback: '');

  static Future<void> init() async {
    final packageInfo = await PackageInfo.fromPlatform();
    final packageName = packageInfo.packageName;

    switch (packageName) {
      case 'com.phuthojobs.mobile':
        await dotenv.load(fileName: 'env/.env.prod');
        break;
      case 'com.phuthojobs.mobile.dev':
        await dotenv.load(fileName: 'env/.env.dev');
        break;
      default:
        await dotenv.load(fileName: 'env/.env.dev');
        break;
    }
  }
}