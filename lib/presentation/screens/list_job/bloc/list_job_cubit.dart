import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:phu_tho_mobile/application/enums/load_status.dart';
import 'package:phu_tho_mobile/application/enums/type_action.dart';
import 'package:phu_tho_mobile/data/data_sources/storage/shared_preferences/shared_preferences_helper.dart';
import 'package:phu_tho_mobile/di.dart';
import 'package:phu_tho_mobile/domain/models/common/item_filter.dart';
import 'package:phu_tho_mobile/domain/models/request/job_request/job_request.dart';
import 'package:phu_tho_mobile/domain/models/response/filter_response/filter_response.dart';
import 'package:phu_tho_mobile/domain/models/response/job/job_response.dart';
import 'package:phu_tho_mobile/domain/repositories/dict_item_repository.dart';
import 'package:phu_tho_mobile/domain/repositories/job_repository.dart';
import 'package:phu_tho_mobile/presentation/screens/list_job/bloc/list_job_state.dart';

class ListJobCubit extends Cubit<ListJobState> {
  ListJobCubit() : super(const ListJobState());
  final _repo = getIt.get<JobRepository>();
  final filterRepo = getIt.get<DictItemRepository>();
  final sharedPreferencesHelper = getIt.get<SharedPreferencesHelper>();

  Future<void> getJobs() async {
    try {
      emit(state.copyWith(status: LoadStatus.loading));
      JobRequest request = state.request.copyWith(pageIndex: 1);
      final response = await _repo.getJobs(request, state.typeAction);
      if (response.isRight) {
        return emit(state.copyWith(
            status: LoadStatus.success,
            jobs: response.right.listItem,
            request: request.copyWith(pageIndex: 2),
            hasNextPage: response.right.hasNextPage));
      }
      emit(state.copyWith(status: LoadStatus.failure));
    } catch (e) {
      emit(state.copyWith(status: LoadStatus.failure));
    }
  }

  Future<void> getJobsMore() async {
    try {
      if (!state.hasNextPage) return;
      emit(state.copyWith(statusMore: LoadStatus.loading));
      JobRequest request = state.request;
      final response = await _repo.getJobs(request, state.typeAction);
      if (response.isRight) {
        List<JobResponse> jobs = [...state.jobs, ...response.right.listItem];
        return emit(state.copyWith(
            jobs: jobs,
            statusMore: LoadStatus.success,
            request: request.copyWith(pageIndex: state.request.pageIndex + 1),
            hasNextPage: response.right.hasNextPage));
      }
      emit(state.copyWith(statusMore: LoadStatus.failure));
    } catch (e) {
      emit(state.copyWith(statusMore: LoadStatus.failure));
    }
  }

  void changeVisible(bool value) {
    emit(state.copyWith(isShowSearch: value));
  }

  void changeRequest(
      {String? title,
      int? idBusiness,
      String? isApproved,
      String? jobName,
      String? province,
      String? salaryFilter,
      String? district,
      String? level,
      String? exp,
      int? gender,
      String? expire,
      String? positioned}) {
    emit(state.copyWith(
        request: state.request.copyWith(
            titleFilter: title,
            isApproved: isApproved,
            jobName: jobName,
            province: province,
            district: district,
            salaryFilter: salaryFilter,
            level: level,
            exp: exp,
            expire: expire,
            gender: gender,
            positioned: positioned,
            idBusiness: idBusiness)));
  }

  void changeValues({
    ItemFilter? isApproved,
    ItemFilter? jobName,
    ItemFilter? province,
    ItemFilter? salaryFilter,
    ItemFilter? district,
    ItemFilter? level,
    ItemFilter? exp,
    ItemFilter? gender,
    ItemFilter? positioned,
    ItemFilter? expire,
  }) {
    emit(state.copyWith(
        isApproved: isApproved,
        valueJob: jobName,
        valueProvince: province,
        valueDistrict: district,
        valueSalary: salaryFilter,
        valueLevel: level,
        valueExp: exp,
        valueGender: gender,
        valuePosition: positioned,
        expire: expire));
  }

  Future<void> getAllFilter() async {
    try {
      final listProvince = await filterRepo.getProvince();
      final listGender = await filterRepo.getGender();
      final listExp = await filterRepo.getExp();
      final listLevel = await filterRepo.getLevel();
      final listSalary = await filterRepo.getSalary();
      final listJob = await filterRepo.getJob();
      final listPosition = await filterRepo.getPosition();

      emit(state.copyWith(
          listProvince: [...state.listProvince, ...listProvince.right],
          listGender: [...state.listGender, ...listGender.right],
          listExp: [...state.listExp, ...listExp.right],
          listLevel: [...state.listLevel, ...listLevel.right],
          listSalary: [...state.listSalary, ...listSalary.right],
          listJob: [...state.listJob, ...listJob.right],
          listPosition: [...state.listPosition, ...listPosition.right]));
    } catch (e) {
      return;
    }
  }

  Future<void> getFilterDistrict() async {
    try {
      const firstItem = FilterResponse(text: "Chọn huyện", value: '');
      final listDistrict =
          await filterRepo.getDistrict(state.valueProvince.getValues());
      emit(state.copyWith(
        listDistrict: [firstItem, ...listDistrict.right],
      ));
    } catch (e) {
      return;
    }
  }

  void onChangeTypeAction(TypeAction type) {
    emit(state.copyWith(typeAction: type));
  }

  Future<void> deleteJob(int id) async {
    try {
      emit(state.copyWith(loadAction: LoadStatus.loading));
      final response = await _repo.deleteJob(id);
      if (response.isRight) {
        emit(state.copyWith(
            loadAction: LoadStatus.success, message: response.right));
        return;
      }
      emit(state.copyWith(
          loadAction: LoadStatus.failure, message: response.left));
    } catch (e) {
      emit(state.copyWith(loadAction: LoadStatus.failure));
    }
  }

  void reset() {
    emit(ListJobState(
      listApproved: state.listApproved,
      listDistrict: state.listDistrict,
      listExp: state.listExp,
      listGender: state.listGender,
      listPosition: state.listPosition,
      listLevel: state.listLevel,
      listSalary: state.listSalary,
      listProvince: state.listProvince,
      listExpire: state.listExpire,
      listJob: state.listJob,
    ));
  }

  Future<void> applyJob(int id) async {
    emit(state.copyWith(loadApplyJob: LoadStatus.loading));
    final login = await sharedPreferencesHelper.getLoggedInfo();
    if (login?.accessToken.isNotEmpty ?? false) {
      try {
        final response = await _repo.applyJob(id);
        if (response.isRight) {
          emit(state.copyWith(
              loadApplyJob: LoadStatus.success, message: response.right));
          return;
        }
        emit(state.copyWith(
            loadApplyJob: LoadStatus.failure, message: response.left));
      } catch (e) {
        emit(state.copyWith(
            loadApplyJob: LoadStatus.failure, message: e.toString()));
      }
      return;
    }
    emit(state.copyWith(
        loadApplyJob: LoadStatus.failure,
        message: "Cần đăng nhập để sử dụng tính năng này"));
  }
}
