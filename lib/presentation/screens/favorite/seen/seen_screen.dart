import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:phu_tho_mobile/application/constants/app_color.dart';
import 'package:phu_tho_mobile/gen/assets.gen.dart';

import '../../../common_widgets/find_job.dart';

class SeenScreen extends StatelessWidget {
  const SeenScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: FindJob(title: tr("viewed_jobs")),
    );
  }
}
