import 'package:equatable/equatable.dart';
import 'package:phu_tho_mobile/application/enums/load_status.dart';
import 'package:phu_tho_mobile/domain/models/response/worker/detail_worker_response.dart';

class DetailExtractWorkerState extends Equatable {
  final LoadStatus loadStatus;
  final DetailWorkerResponse detailWorkerResponse;

  const DetailExtractWorkerState(
      {this.loadStatus = LoadStatus.initial,
      this.detailWorkerResponse = const DetailWorkerResponse()});

  DetailExtractWorkerState copyWith(
      {LoadStatus? loadStatus, DetailWorkerResponse? detailWorkerResponse}) {
    return DetailExtractWorkerState(
        loadStatus: loadStatus ?? this.loadStatus,
        detailWorkerResponse:
            detailWorkerResponse ?? this.detailWorkerResponse);
  }

  @override
  List<Object?> get props => [loadStatus, detailWorkerResponse];
}
