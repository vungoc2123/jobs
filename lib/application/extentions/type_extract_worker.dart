import 'package:easy_localization/easy_localization.dart';
import 'package:phu_tho_mobile/application/enums/extract_worker.dart';

extension TypeExtractWorkerExtension on TypeExtractWorker {
  String get nameTitle {
    switch (this) {
      case TypeExtractWorker.foreignInVn:
        return tr("workersForeign");
      case TypeExtractWorker.inBusiness:
        return tr("workersInBusiness");
      case TypeExtractWorker.manageInBusiness:
        return tr("workersInBusiness");
      case TypeExtractWorker.manageForeignInVn:
        return tr("workersForeign");
      case TypeExtractWorker.manageVnInForeign:
        return tr("workersVietNam");
      default:
        return tr("workersVietNam");
    }
  }
}
