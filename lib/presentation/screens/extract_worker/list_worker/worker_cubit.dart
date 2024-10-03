import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:phu_tho_mobile/application/enums/extract_worker.dart';
import 'package:phu_tho_mobile/application/enums/load_status.dart';
import 'package:phu_tho_mobile/di.dart';
import 'package:phu_tho_mobile/domain/models/request/worker/worker_request.dart';
import 'package:phu_tho_mobile/domain/repositories/worker_repository.dart';
import 'package:phu_tho_mobile/presentation/screens/extract_worker/list_worker/workers_state.dart';

class WorkerCubit extends Cubit<WorkerState> {
  WorkerCubit() : super(const WorkerState());

  final _repo = getIt.get<WorkerRepository>();

  void changeRequest(WorkerRequest newRequest) {
    emit(state.copyWith(request: newRequest));
  }

  void changeTypeWorker(TypeExtractWorker typeExtractWorker) {
    emit(state.copyWith(typeExtractWorker: typeExtractWorker));
  }

  Future<void> getWorkers() async {
    try {
      emit(state.copyWith(loadStatus: LoadStatus.loading));
      final response =
          await _repo.getExtractWorkers(state.request, state.typeExtractWorker);
      if (response.isRight) {
        emit(state.copyWith(
            loadStatus: LoadStatus.success,
            workers: response.right.listItem,
            hasNextPage: response.right.hasNextPage));
        return;
      }
      emit(state.copyWith(
          loadStatus: LoadStatus.failure, message: response.left));
    } catch (e) {
      emit(state.copyWith(
          loadStatus: LoadStatus.failure, message: e.toString()));
    }
  }

  Future<void> getMoreWorkers() async {
    try {
      if (!state.hasNextPage || state.loadMoreStatus == LoadStatus.loading) {
        return;
      }
      emit(state.copyWith(loadMoreStatus: LoadStatus.loading));
      changeRequest(
          state.request.copyWith(pageIndex: state.request.pageIndex + 1));
      final response =
          await _repo.getExtractWorkers(state.request, state.typeExtractWorker);
      if (response.isRight) {
        emit(state.copyWith(
            loadMoreStatus: LoadStatus.success,
            workers: [...state.workers, ...response.right.listItem],
            hasNextPage: response.right.hasNextPage));
        return;
      }
      emit(state.copyWith(loadMoreStatus: LoadStatus.failure));
    } catch (e) {
      emit(state.copyWith(loadMoreStatus: LoadStatus.failure));
    }
  }
}
