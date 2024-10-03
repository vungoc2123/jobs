import 'package:bloc/bloc.dart';
import 'package:phu_tho_mobile/application/enums/load_status.dart';
import 'package:phu_tho_mobile/di.dart';
import 'package:phu_tho_mobile/domain/models/common/item_filter.dart';
import 'package:phu_tho_mobile/domain/models/response/filter_response/filter_response.dart';
import 'package:phu_tho_mobile/domain/repositories/candidate_repository.dart';
import 'package:phu_tho_mobile/domain/repositories/dict_item_repository.dart';
import 'package:phu_tho_mobile/presentation/screens/candidate/list_candidate/candidate_state.dart';

class CandidateCubit extends Cubit<CandidateState> {
  CandidateCubit() : super(const CandidateState());

  final repo = getIt.get<CandidateRepository>();
  final filterRepo = getIt.get<DictItemRepository>();

  Future<void> getCandidate() async {
    try {
      emit(state.copyWith(status: LoadStatus.loading));
      final response = await repo.getAllCandidate(state.request);
      if (response.isRight) {
        emit(state.copyWith(
            status: LoadStatus.success,
            listCandidate: response.right.listItem,
            canLoad: response.right.hasNextPage));
        return;
      }
      emit(
          state.copyWith(status: LoadStatus.failure, errorMess: response.left));
      return;
    } catch (e) {
      emit(state.copyWith(status: LoadStatus.failure, errorMess: e.toString()));
    }
  }

  void changeRequest(
      {int? pageIndex,
      String? title,
      String? positioned,
      String? province,
      String? district,
      String? jobName,
      String? salaryFilter,
      int? gender,
      String? level,
      String? exp}) {
    emit(state.copyWith(
        request: state.request.copyWith(
            pageIndex: pageIndex,
            titleFilter: title,
            province: province,
            positioned: positioned,
            jobName: jobName,
            district: district,
            exp: exp,
            gender: gender,
            level: level,
            salaryFilter: salaryFilter)));
  }

  void changeValues(
      {ItemFilter? positioned,
      ItemFilter? province,
      ItemFilter? district,
      ItemFilter? jobName,
      ItemFilter? salaryFilter,
      ItemFilter? gender,
      ItemFilter? level,
      ItemFilter? exp}) {
    emit(state.copyWith(
        valuePosition: positioned,
        valueProvince: province,
        valueDistrict: district,
        valueExp: exp,
        valueGender: gender,
        valueJob: jobName,
        valueLevel: level,
        valueSalary: salaryFilter));
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
      print(e.toString());
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

  void reset() {
    emit(CandidateState(
      listDistrict: state.listDistrict,
      listExp: state.listExp,
      listGender: state.listGender,
      listPosition: state.listPosition,
      listLevel: state.listLevel,
      listSalary: state.listSalary,
      listProvince: state.listProvince,
      listJob: state.listJob,
    ));
  }
}
