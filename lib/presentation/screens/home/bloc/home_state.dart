import 'package:equatable/equatable.dart';
import 'package:phu_tho_mobile/application/enums/load_status.dart';
import 'package:phu_tho_mobile/domain/models/response/banner/banner_response.dart';
import 'package:phu_tho_mobile/domain/models/response/business/business_response.dart';
import 'package:phu_tho_mobile/domain/models/response/cadidate/candidate_response.dart';
import 'package:phu_tho_mobile/domain/models/response/job/job_response.dart';
import 'package:phu_tho_mobile/domain/models/response/notification/notification_response.dart';

class HomeState extends Equatable {
  final LoadStatus loadBannerStatus;
  final LoadStatus loadJobStatus;
  final LoadStatus loadCandidateStatus;
  final LoadStatus loadBusinessStatus;
  final LoadStatus loadNotificationStatus;
  final List<BannerResponse> banners;
  final List<JobResponse> jobs;
  final List<CandidateResponse> listCandidate;
  final List<BusinessResponse> business;
  final List<NotificationResponse> notifications;

  const HomeState(
      {this.loadBannerStatus = LoadStatus.loading,
      this.loadJobStatus = LoadStatus.initial,
      this.loadCandidateStatus = LoadStatus.initial,
      this.loadBusinessStatus = LoadStatus.initial,
      this.loadNotificationStatus = LoadStatus.initial,
      this.banners = const [],
      this.jobs = const [],
      this.listCandidate = const [],
      this.business = const [],
      this.notifications = const []});

  HomeState copyWith({
    LoadStatus? loadBannerStatus,
    LoadStatus? loadJobStatus,
    LoadStatus? loadCandidateStatus,
    LoadStatus? loadBusinessStatus,
    LoadStatus? loadNotificationStatus,
    List<BannerResponse>? banners,
    List<JobResponse>? jobs,
    List<CandidateResponse>? listCandidate,
    List<BusinessResponse>? business,
    List<NotificationResponse>? notifications,
  }) {
    return HomeState(
        banners: banners ?? this.banners,
        loadJobStatus: loadJobStatus ?? this.loadJobStatus,
        loadCandidateStatus: loadCandidateStatus ?? this.loadCandidateStatus,
        loadBusinessStatus: loadBusinessStatus ?? this.loadBusinessStatus,
        loadBannerStatus: loadBannerStatus ?? this.loadBannerStatus,
        loadNotificationStatus:
            loadNotificationStatus ?? this.loadNotificationStatus,
        jobs: jobs ?? this.jobs,
        listCandidate: listCandidate ?? this.listCandidate,
        business: business ?? this.business,
        notifications: notifications ?? this.notifications);
  }

  @override
  List<Object?> get props => [
        loadBannerStatus,
        loadJobStatus,
        loadCandidateStatus,
        listCandidate,
        banners,
        jobs,
        business,
        loadBusinessStatus,
        loadNotificationStatus,
        notifications
      ];
}
