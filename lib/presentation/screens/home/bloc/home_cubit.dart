import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:phu_tho_mobile/application/enums/load_status.dart';
import 'package:phu_tho_mobile/application/enums/type_action.dart';
import 'package:phu_tho_mobile/data/data_sources/storage/shared_preferences/shared_preferences_helper.dart';
import 'package:phu_tho_mobile/di.dart';
import 'package:phu_tho_mobile/domain/models/request/candidate_profile_request/candidate_profile_request.dart';
import 'package:phu_tho_mobile/domain/models/request/job_request/job_request.dart';
import 'package:phu_tho_mobile/domain/repositories/banner_repository.dart';
import 'package:phu_tho_mobile/domain/repositories/candidate_repository.dart';
import 'package:phu_tho_mobile/domain/repositories/business_repository.dart';
import 'package:phu_tho_mobile/domain/repositories/job_repository.dart';
import 'package:phu_tho_mobile/domain/repositories/notification_repository.dart';
import 'package:phu_tho_mobile/presentation/screens/home/bloc/home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(const HomeState());
  final _repoBanner = getIt.get<BannerRepository>();
  final _repoJob = getIt.get<JobRepository>();
  final _repoCandidate = getIt.get<CandidateRepository>();
  final _repoBusiness = getIt.get<BusinessRepository>();
  final _repoNotification = getIt.get<NotificationRepository>();

  Future<void> getBanner() async {
    try {
      emit(state.copyWith(loadBannerStatus: LoadStatus.loading));
      final response = await _repoBanner.getBanner();
      if (response.isRight) {
        emit(state.copyWith(
            loadBannerStatus: LoadStatus.success, banners: response.right));
        return;
      }
      emit(state.copyWith(loadBannerStatus: LoadStatus.failure));
    } catch (e) {
      emit(state.copyWith(loadBannerStatus: LoadStatus.failure));
    }
  }

  Future<void> getJobs() async {
    try {
      emit(state.copyWith(loadJobStatus: LoadStatus.loading));
      JobRequest request = const JobRequest(pageSize: 9, isBestJob: true);
      final response = await _repoJob.getJobs(request, TypeAction.extract);
      if (response.isRight) {
        return emit(state.copyWith(
            jobs: response.right.listItem, loadJobStatus: LoadStatus.success));
      }
      emit(state.copyWith(loadJobStatus: LoadStatus.failure));
    } catch (e) {
      emit(state.copyWith(loadJobStatus: LoadStatus.failure));
    }
  }

  Future<void> getCandidate() async {
    try {
      emit(state.copyWith(loadCandidateStatus: LoadStatus.loading));
      final response =
          await _repoCandidate.getAllCandidate(const CandidateProFileRequest());
      if (response.isRight) {
        emit(state.copyWith(
          loadCandidateStatus: LoadStatus.success,
          listCandidate: response.right.listItem,
        ));
        return;
      }
      emit(state.copyWith(loadCandidateStatus: LoadStatus.failure));
      return;
    } catch (e) {
      emit(state.copyWith(loadCandidateStatus: LoadStatus.failure));
    }
  }

  Future<void> getBusiness() async {
    try {
      emit(state.copyWith(loadBusinessStatus: LoadStatus.loading));
      final response = await _repoBusiness.getHotBusiness();
      if (response.isRight) {
        emit(state.copyWith(
            loadBusinessStatus: LoadStatus.success, business: response.right));
        return;
      }
      emit(state.copyWith(loadBusinessStatus: LoadStatus.failure));
    } catch (e) {
      emit(state.copyWith(loadBusinessStatus: LoadStatus.failure));
    }
  }

  Future<void> getNotificationUnRead() async {
    try {
      final loggedInfo = await getIt<SharedPreferencesHelper>().getLoggedInfo();
      if (loggedInfo?.accessToken != '') {
        emit(state.copyWith(loadNotificationStatus: LoadStatus.loading));
        final response = await _repoNotification.getAllUnReadNotification();
        if (response.isRight) {
          emit(state.copyWith(
              loadNotificationStatus: LoadStatus.success,
              notifications: response.right));
          return;
        }
        emit(state.copyWith(loadNotificationStatus: LoadStatus.failure));
      }
    } catch (e) {
      emit(state.copyWith(loadNotificationStatus: LoadStatus.failure));
    }
  }
}
