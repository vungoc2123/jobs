import 'package:either_dart/src/either.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:phu_tho_mobile/application/enums/extract_worker.dart';
import 'package:phu_tho_mobile/application/enums/load_status.dart';
import 'package:phu_tho_mobile/di.dart';
import 'package:phu_tho_mobile/domain/models/response/worker/detail_worker_response.dart';
import 'package:phu_tho_mobile/domain/repositories/worker_repository.dart';
import 'package:phu_tho_mobile/presentation/screens/extract_worker/detail_worker/detail_extract_worker_state.dart';

class DetailExtractWorkerCubit extends Cubit<DetailExtractWorkerState> {
  DetailExtractWorkerCubit() : super(const DetailExtractWorkerState());

  final _repo = getIt.get<WorkerRepository>();

  Future<void> getDetailWorker(
      int id, TypeExtractWorker typeExtractWorker) async {
    try {
      emit(state.copyWith(loadStatus: LoadStatus.loading));
      Either<String, DetailWorkerResponse> response;
      if (typeExtractWorker == TypeExtractWorker.manageForeignInVn ||
          typeExtractWorker == TypeExtractWorker.manageInBusiness ||
          typeExtractWorker == TypeExtractWorker.manageVnInForeign) {
        response = await _repo.getManageDetailWorkers(id);
      } else {
        response = await _repo.getExtractDetailWorkers(id, typeExtractWorker);
      }
      if (response.isRight) {
        emit(state.copyWith(
            loadStatus: LoadStatus.success,
            detailWorkerResponse: response.right));
        return;
      }
      emit(state.copyWith(loadStatus: LoadStatus.failure));
    } catch (e) {
      emit(state.copyWith(loadStatus: LoadStatus.failure));
    }
  }
}
