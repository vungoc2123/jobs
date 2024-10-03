import 'package:equatable/equatable.dart';
import 'package:phu_tho_mobile/application/enums/load_status.dart';
import 'package:phu_tho_mobile/application/enums/type_action.dart';
import 'package:phu_tho_mobile/domain/models/response/job/job_response.dart';

class JobOfBusinessState extends Equatable {
  final LoadStatus loadStatus;
  final List<JobResponse> jobs;
  final TypeAction typeAction;

  const JobOfBusinessState(
      {this.loadStatus = LoadStatus.initial,
      this.jobs = const [],
      this.typeAction = TypeAction.extract});

  JobOfBusinessState copyWith(
      {LoadStatus? loadStatus,
      List<JobResponse>? jobs,
      TypeAction? typeAction}) {
    return JobOfBusinessState(
        loadStatus: loadStatus ?? this.loadStatus,
        jobs: jobs ?? this.jobs,
        typeAction: typeAction ?? this.typeAction);
  }

  @override
  List<Object?> get props => [loadStatus, jobs, typeAction];
}
