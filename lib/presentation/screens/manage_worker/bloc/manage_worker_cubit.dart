import 'package:bloc/bloc.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:phu_tho_mobile/application/enums/extract_worker.dart';
import 'package:phu_tho_mobile/application/enums/load_status.dart';
import 'package:phu_tho_mobile/application/enums/type_action.dart';
import 'package:phu_tho_mobile/di.dart';
import 'package:phu_tho_mobile/domain/models/request/business/business_request.dart';
import 'package:phu_tho_mobile/domain/models/request/worker/worker_request.dart';
import 'package:phu_tho_mobile/domain/models/response/business/business_response.dart';
import 'package:phu_tho_mobile/domain/repositories/business_repository.dart';
import 'package:phu_tho_mobile/domain/repositories/worker_repository.dart';
import 'package:phu_tho_mobile/presentation/screens/manage_worker/bloc/manage_worker_state.dart';

class ManageWorkerCubit extends Cubit<ManageWorkerState> {
  ManageWorkerCubit() : super(const ManageWorkerState());
  final _repo = getIt.get<WorkerRepository>();
  final _repoBusiness = getIt.get<BusinessRepository>();

  void changeRequest(WorkerRequest newRequest) {
    emit(state.copyWith(request: newRequest));
  }

  Future<void> getWorkers(TypeExtractWorker type) async {
    try {
      emit(state.copyWith(loadStatus: LoadStatus.loading));
      final response =
          await _repo.getManageWorkers(type: type, request: state.request);
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

  Future<void> getMoreWorkers(TypeExtractWorker type) async {
    try {
      if (!state.hasNextPage || state.loadMoreStatus == LoadStatus.loading) {
        return;
      }
      emit(state.copyWith(loadMoreStatus: LoadStatus.loading));
      WorkerRequest request =
          state.request.copyWith(pageIndex: state.request.pageIndex + 1);
      final response =
          await _repo.getManageWorkers(type: type, request: request);
      if (response.isRight) {
        emit(state.copyWith(
            loadMoreStatus: LoadStatus.success,
            workers: [...state.workers, ...response.right.listItem],
            request:
                state.request.copyWith(pageIndex: state.request.pageIndex + 1),
            hasNextPage: response.right.hasNextPage));
        return;
      }
      emit(state.copyWith(loadMoreStatus: LoadStatus.failure));
    } catch (e) {
      emit(state.copyWith(loadMoreStatus: LoadStatus.failure));
    }
  }

  Future<void> getBusiness() async {
    try {
      emit(state.copyWith(loadStatusBusiness: LoadStatus.loading));
      final response = await _repoBusiness.getBusiness(
          state.requestBusiness, TypeAction.manage);
      BusinessResponse business =
          BusinessResponse(id: 0, nameBusiness: tr("business"));
      if (response.isRight) {
        emit(state.copyWith(
            loadStatusBusiness: LoadStatus.success,
            hasNextPageBusiness: response.right.hasNextPage,
            business: [business, ...response.right.listItem]));
        return;
      }
      emit(state.copyWith(loadStatusBusiness: LoadStatus.failure));
    } catch (e) {
      emit(state.copyWith(loadStatusBusiness: LoadStatus.failure));
    }
  }

  Future<void> getMoreBusiness() async {
    try {
      if (!state.hasNextPageBusiness ||
          state.loadMoreStatusBusiness == LoadStatus.loading) {
        return;
      }
      emit(state.copyWith(loadMoreStatusBusiness: LoadStatus.loading));
      onChangeRequestBusiness(state.requestBusiness
          .copyWith(pageIndex: state.requestBusiness.pageIndex + 1));
      final response = await _repoBusiness.getBusiness(
          state.requestBusiness, TypeAction.manage);
      if (response.isRight) {
        emit(state.copyWith(
            loadMoreStatusBusiness: LoadStatus.success,
            hasNextPageBusiness: response.right.hasNextPage,
            business: [...state.business, ...response.right.listItem]));
        return;
      }
      emit(state.copyWith(loadMoreStatusBusiness: LoadStatus.failure));
    } catch (e) {
      emit(state.copyWith(loadMoreStatusBusiness: LoadStatus.failure));
    }
  }

  Future<void> deleteManageWorker(int id) async {
    try {
      emit(state.copyWith(statusDelete: LoadStatus.loading));
      final response = await _repo.deleteManageWorker(id);
      if (response.isRight) {
        emit(state.copyWith(
          statusDelete: LoadStatus.success,
        ));
        return;
      }
      emit(state.copyWith(statusDelete: LoadStatus.failure));
    } catch (e) {
      emit(state.copyWith(statusDelete: LoadStatus.failure));
    }
  }

  void onChangeRequestBusiness(BusinessRequest newRequest) {
    emit(state.copyWith(requestBusiness: newRequest));
  }

  void changeTitleBusiness(String value) {
    emit(state.copyWith(titleBusiness: value));
  }
}
