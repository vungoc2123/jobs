import 'package:equatable/equatable.dart';
import 'package:phu_tho_mobile/application/enums/load_status.dart';
import 'package:phu_tho_mobile/domain/models/request/trading_job/trading_job_request.dart';
import 'package:phu_tho_mobile/domain/models/response/trading_job_response/trading_job_response.dart';

class TradingJobState extends Equatable {
  final TradingJobRequest request;
  final List<TradingJobResponse> tradingJobs;
  final bool hasNextPage;
  final LoadStatus status;
  final LoadStatus statusMore;
  final bool isShowSearch;
  final String searchBy;

  const TradingJobState(
      {this.request = const TradingJobRequest(),
      this.tradingJobs = const [],
      this.hasNextPage = false,
      this.status = LoadStatus.initial,
      this.statusMore = LoadStatus.initial,
      this.isShowSearch = false,
      this.searchBy = ''});

  TradingJobState copyWith(
      {TradingJobRequest? request,
        List<TradingJobResponse>? tradingJobs,
        bool? isShowSearch,
        bool? hasNextPage,
        LoadStatus? status,
        String? searchBy,
        LoadStatus? statusDelete,
        LoadStatus? statusMore}) {
    return TradingJobState(
        request: request ?? this.request,
        isShowSearch: isShowSearch ?? this.isShowSearch,
        hasNextPage: hasNextPage ?? this.hasNextPage,
        status: status ?? this.status,
        statusMore: statusMore ?? this.statusMore,
        searchBy: searchBy ?? this.searchBy,
        tradingJobs: tradingJobs ?? this.tradingJobs);
  }

  @override
  List<Object?> get props => [
    request,
    tradingJobs,
    searchBy,
    hasNextPage,
    status,
    statusMore,
    isShowSearch];
}
