import 'package:bloc/bloc.dart';
import 'package:phu_tho_mobile/application/enums/load_status.dart';
import 'package:phu_tho_mobile/di.dart';
import 'package:phu_tho_mobile/domain/models/request/trading_job/trading_job_request.dart';
import 'package:phu_tho_mobile/domain/models/response/trading_job_response/trading_job_response.dart';
import 'package:phu_tho_mobile/domain/repositories/trading_job_repository.dart';
import 'package:phu_tho_mobile/presentation/screens/trading_job/bloc/trading_job_state.dart';

class TradingJobCubit extends Cubit<TradingJobState> {
  TradingJobCubit() : super(const TradingJobState());

  final _repo = getIt.get<TradingJobRepository>();

  Future<void> getTradingJobs() async {
    try {
      emit(state.copyWith(status: LoadStatus.loading));
      TradingJobRequest request = state.request.copyWith(pageIndex: 1);
      final response = await _repo.getTradingJobs(request);
      if (response.isRight) {
        return emit(state.copyWith(
            status: LoadStatus.success,
            tradingJobs: response.right.listItem,
            request: request.copyWith(pageIndex: 2),
            hasNextPage: response.right.hasNextPage));
      }
      emit(state.copyWith(status: LoadStatus.failure));
    } catch (e) {
      emit(state.copyWith(status: LoadStatus.failure));
    }
  }

  Future<void> getTradingJobsMore() async {
    try {
      if (!state.hasNextPage) return;
      emit(state.copyWith(statusMore: LoadStatus.loading));
      TradingJobRequest request = state.request;
      final response = await _repo.getTradingJobs(request);
      if (response.isRight) {
        List<TradingJobResponse> tradingJobs = [
          ...state.tradingJobs,
          ...response.right.listItem
        ];
        return emit(state.copyWith(
            tradingJobs: tradingJobs,
            statusMore: LoadStatus.success,
            request:
                state.request.copyWith(pageIndex: state.request.pageIndex + 1),
            hasNextPage: response.right.hasNextPage));
      }
      emit(state.copyWith(statusMore: LoadStatus.failure));
    } catch (e) {
      emit(state.copyWith(statusMore: LoadStatus.failure));
    }
  }

  void changeSearchBy(String value) {
    emit(state.copyWith(searchBy: value));
  }

  void changeVisible(bool value) {
    emit(state.copyWith(isShowSearch: value));
  }

  void changeRequest(
      {String? name,
      String? code,
      String? timeStart,
      String? timeEnd,
      pageSize,
      int? pageIndex,
      bool reset = false}) {
    if (reset) {
      return emit(state.copyWith(request: const TradingJobRequest()));
    }
    emit(state.copyWith(
        request: state.request.copyWith(
            name: name,
            code: code,
            timeStart: timeStart,
            timeEnd: timeEnd,
            pageSize: pageSize,
            pageIndex: pageIndex)));
  }
}
