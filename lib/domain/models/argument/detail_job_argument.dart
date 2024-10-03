import 'package:phu_tho_mobile/application/enums/type_action.dart';
import 'package:phu_tho_mobile/domain/models/response/job/job_response.dart';

class DetailJobArgument {
  final TypeAction typeAction;
  final JobResponse job;

  const DetailJobArgument({required this.typeAction, required this.job});
}
