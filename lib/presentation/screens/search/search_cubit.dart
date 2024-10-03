import 'package:bloc/bloc.dart';
import 'package:phu_tho_mobile/application/enums/type_action.dart';
import 'package:phu_tho_mobile/presentation/screens/search/search_state.dart';

import '../../../application/enums/load_status.dart';
import '../../../di.dart';
import '../../../domain/repositories/business_repository.dart';
import '../../../domain/repositories/candidate_repository.dart';
import '../../../domain/repositories/job_repository.dart';

class SearchCubit extends Cubit<SearchState> {
  SearchCubit() : super(const SearchState());

  final businessRepo = getIt.get<BusinessRepository>();
  final candidateRepo = getIt.get<CandidateRepository>();
  final jobRepo = getIt.get<JobRepository>();

  Future<void> getJobs() async {
    try {
      emit(state.copyWith(
          statusJobs: LoadStatus.loading,
          jobRequest:
              state.jobRequest.copyWith(titleFilter: state.searchQuery)));
      final response =
          await jobRepo.getJobs(state.jobRequest, TypeAction.extract);
      if (response.isRight) {
        return emit(state.copyWith(
          statusJobs: LoadStatus.success,
          jobs: response.right.listItem,
        ));
      }
      emit(state.copyWith(statusJobs: LoadStatus.failure));
    } catch (e) {
      emit(state.copyWith(statusJobs: LoadStatus.failure));
    }
  }

  Future<void> getCandidate() async {
    try {
      emit(state.copyWith(
          statusCandidate: LoadStatus.loading,
          candidateRequest:
              state.candidateRequest.copyWith(titleFilter: state.searchQuery)));
      final response =
          await candidateRepo.getAllCandidate(state.candidateRequest);
      if (response.isRight) {
        emit(state.copyWith(
          statusCandidate: LoadStatus.success,
          listCandidate: response.right.listItem,
        ));
        return;
      }
      emit(state.copyWith(statusCandidate: LoadStatus.failure));
      return;
    } catch (e) {
      emit(state.copyWith(statusCandidate: LoadStatus.failure));
    }
  }

  Future<void> getBusiness() async {
    try {
      emit(state.copyWith(
          statusBusiness: LoadStatus.loading,
          businessRequest:
              state.businessRequest.copyWith(nameBusiness: state.searchQuery)));
      final response = await businessRepo.getBusiness(
          state.businessRequest, TypeAction.extract);
      if (response.isRight) {
        emit(state.copyWith(
            statusBusiness: LoadStatus.success,
            business: response.right.listItem));
        return;
      }
      emit(state.copyWith(statusBusiness: LoadStatus.failure));
    } catch (e) {
      emit(state.copyWith(statusBusiness: LoadStatus.failure));
    }
  }

  void changeQuery(String value){
    emit(state.copyWith(searchQuery: value));
  }
}
