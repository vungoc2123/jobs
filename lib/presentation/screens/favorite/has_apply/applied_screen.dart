import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../common_widgets/find_job.dart';

class JobAppliedScreen extends StatelessWidget {
  const JobAppliedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: FindJob(title: tr("job_applied")),
    );
  }
}