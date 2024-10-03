import 'package:equatable/equatable.dart';
import 'package:phu_tho_mobile/application/enums/load_status.dart';

import '../../../domain/models/request/business/business_request.dart';
import '../../../domain/models/request/candidate_profile_request/candidate_profile_request.dart';
import '../../../domain/models/request/job_request/job_request.dart';
import '../../../domain/models/response/business/business_response.dart';
import '../../../domain/models/response/cadidate/candidate_response.dart';
import '../../../domain/models/response/job/job_response.dart';

class SearchState extends Equatable {
  final String searchQuery;
  final List<BusinessResponse> business;
  final List<JobResponse> jobs;
  final List<CandidateResponse> listCandidate;
  final LoadStatus statusBusiness;
  final LoadStatus statusJobs;
  final LoadStatus statusCandidate;
  final JobRequest jobRequest;
  final CandidateProFileRequest candidateRequest;
  final BusinessRequest businessRequest;

  const SearchState({
    this.searchQuery = '',
    this.business = const [],
    this.listCandidate = const [],
    this.jobs = const [],
    this.statusBusiness = LoadStatus.initial,
    this.statusCandidate = LoadStatus.initial,
    this.statusJobs = LoadStatus.initial,
    this.jobRequest = const JobRequest(pageSize: 5, pageIndex: 1),
    this.candidateRequest =
        const CandidateProFileRequest(pageSize: 5, pageIndex: 1),
    this.businessRequest = const BusinessRequest(pageSize: 5, pageIndex: 1),
  });

  SearchState copyWith({
    String? searchQuery,
    List<BusinessResponse>? business,
    List<JobResponse>? jobs,
    List<CandidateResponse>? listCandidate,
    LoadStatus? statusBusiness,
    LoadStatus? statusJobs,
    LoadStatus? statusCandidate,
    JobRequest? jobRequest,
    CandidateProFileRequest? candidateRequest,
    BusinessRequest? businessRequest,
  }) {
    return SearchState(
      searchQuery: searchQuery ?? this.searchQuery,
      business: business ?? this.business,
      jobs: jobs ?? this.jobs,
      listCandidate: listCandidate ?? this.listCandidate,
      statusBusiness: statusBusiness ?? this.statusBusiness,
      statusJobs: statusJobs ?? this.statusJobs,
      statusCandidate: statusCandidate ?? this.statusCandidate,
      jobRequest: jobRequest ?? this.jobRequest,
      candidateRequest: candidateRequest ?? this.candidateRequest,
      businessRequest: businessRequest ?? this.businessRequest,
    );
  }

  @override
  List<Object?> get props => [
        searchQuery,
        business,
        jobs,
        listCandidate,
        statusCandidate,
        statusCandidate,
        statusJobs,
        jobRequest,
        candidateRequest,
        businessRequest
      ];
}
