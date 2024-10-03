import 'package:equatable/equatable.dart';
import 'package:phu_tho_mobile/application/enums/extract_worker.dart';
import 'package:phu_tho_mobile/application/enums/load_status.dart';
import 'package:phu_tho_mobile/domain/models/request/worker/worker_request.dart';
import 'package:phu_tho_mobile/domain/models/response/worker/worker_response.dart';

class WorkerState extends Equatable {
  final LoadStatus loadStatus;
  final LoadStatus loadMoreStatus;
  final List<WorkerResponse> workers;
  final WorkerRequest request;
  final bool hasNextPage;
  final String message;
  final TypeExtractWorker typeExtractWorker;

  const WorkerState({this.loadStatus = LoadStatus.initial,
    this.loadMoreStatus = LoadStatus.initial,
    this.workers = const [],
    this.request = const WorkerRequest(),
    this.hasNextPage = true,
    this.message = '', this.typeExtractWorker = TypeExtractWorker.vnInForeign});

  WorkerState copyWith({LoadStatus? loadStatus,
    LoadStatus? loadMoreStatus,
    List<WorkerResponse>? workers,
    WorkerRequest? request,
    bool? hasNextPage,
    String? message, TypeExtractWorker? typeExtractWorker}) {
    return WorkerState(
        loadStatus: loadStatus ?? this.loadStatus,
        loadMoreStatus: loadMoreStatus ?? this.loadMoreStatus,
        request: request ?? this.request,
        workers: workers ?? this.workers,
        hasNextPage: hasNextPage ?? this.hasNextPage,
        message: message ?? this.message,
        typeExtractWorker: typeExtractWorker ?? this.typeExtractWorker);
  }

  @override
  List<Object?> get props =>
      [
        loadStatus,
        loadMoreStatus,
        workers,
        request,
        hasNextPage,
        message,
        typeExtractWorker
      ];
}
