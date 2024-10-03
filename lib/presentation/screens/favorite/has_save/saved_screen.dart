import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../common_widgets/find_job.dart';

class JobSavedScreen extends StatelessWidget {
  const JobSavedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: FindJob(title: tr("work_saved")),
    );
  }
}
