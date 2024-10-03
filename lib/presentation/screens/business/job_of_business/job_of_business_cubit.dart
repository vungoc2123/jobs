import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:phu_tho_mobile/application/enums/load_status.dart';
import 'package:phu_tho_mobile/application/enums/type_action.dart';
import 'package:phu_tho_mobile/di.dart';
import 'package:phu_tho_mobile/domain/models/request/job_request/job_request.dart';
import 'package:phu_tho_mobile/domain/repositories/job_repository.dart';
import 'package:phu_tho_mobile/presentation/screens/business/job_of_business/job_of_business_state.dart';

class JobOfBusinessCubit extends Cubit<JobOfBusinessState> {
  JobOfBusinessCubit() : super(const JobOfBusinessState());

  final _repo = getIt.get<JobRepository>();

  Future<void> getJobs(int? idBusiness) async {
    try {
      emit(state.copyWith(loadStatus: LoadStatus.loading));
      JobRequest request = JobRequest(pageSize: 9, idBusiness: idBusiness);
      final response = await _repo.getJobs(request,state.typeAction);
      if (response.isRight) {
        return emit(state.copyWith(
          loadStatus: LoadStatus.success,
          jobs: response.right.listItem,
        ));
      }
      emit(state.copyWith(loadStatus: LoadStatus.failure));
    } catch (e) {
      emit(state.copyWith(loadStatus: LoadStatus.failure));
    }
  }

  void onChangeTypeAction(TypeAction typeAction){
    emit(state.copyWith(typeAction: typeAction));
  }
}
