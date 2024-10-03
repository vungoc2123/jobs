import 'package:equatable/equatable.dart';
import 'package:phu_tho_mobile/application/enums/load_status.dart';
import 'package:phu_tho_mobile/domain/models/request/business/business_request.dart';
import 'package:phu_tho_mobile/domain/models/request/worker/worker_request.dart';
import 'package:phu_tho_mobile/domain/models/response/business/business_response.dart';
import 'package:phu_tho_mobile/domain/models/response/worker/worker_response.dart';

class ManageWorkerState extends Equatable {
  final LoadStatus loadStatus;
  final LoadStatus loadMoreStatus;
  final List<WorkerResponse> workers;
  final WorkerRequest request;
  final bool hasNextPage;
  final String message;

  final List<BusinessResponse> business;
  final LoadStatus loadStatusBusiness;
  final LoadStatus loadMoreStatusBusiness;
  final BusinessRequest requestBusiness;
  final bool hasNextPageBusiness;

  final String titleBusiness;
  final LoadStatus statusDelete;

  const ManageWorkerState(
      {this.loadStatus = LoadStatus.initial,
      this.loadMoreStatus = LoadStatus.initial,
      this.loadStatusBusiness = LoadStatus.initial,
      this.loadMoreStatusBusiness = LoadStatus.initial,
      this.statusDelete = LoadStatus.initial,
      this.workers = const [],
      this.business = const [],
      this.request = const WorkerRequest(idBusiness: 0),
      this.requestBusiness = const BusinessRequest(),
      this.hasNextPage = true,
      this.hasNextPageBusiness = true,
      this.titleBusiness = '',
      this.message = ''});

  ManageWorkerState copyWith(
      {LoadStatus? loadStatus,
      LoadStatus? loadMoreStatus,
      List<WorkerResponse>? workers,
      WorkerRequest? request,
      BusinessRequest? requestBusiness,
      List<BusinessResponse>? business,
      LoadStatus? loadStatusBusiness,
      LoadStatus? loadMoreStatusBusiness,
      LoadStatus? statusDelete,
      bool? hasNextPage,
      bool? hasNextPageBusiness,
      String? titleBusiness,
      String? message}) {
    return ManageWorkerState(
        loadStatus: loadStatus ?? this.loadStatus,
        loadMoreStatus: loadMoreStatus ?? this.loadMoreStatus,
        request: request ?? this.request,
        workers: workers ?? this.workers,
        business: business ?? this.business,
        hasNextPage: hasNextPage ?? this.hasNextPage,
        loadStatusBusiness: loadStatusBusiness ?? this.loadStatusBusiness,
        loadMoreStatusBusiness:
            loadMoreStatusBusiness ?? this.loadMoreStatusBusiness,
        hasNextPageBusiness: hasNextPageBusiness ?? this.hasNextPageBusiness,
        requestBusiness: requestBusiness ?? this.requestBusiness,
        titleBusiness: titleBusiness ?? this.titleBusiness,
        statusDelete: statusDelete ?? this.statusDelete,
        message: message ?? this.message);
  }

  @override
  List<Object?> get props => [
        loadStatus,
        loadMoreStatus,
        loadStatusBusiness,
        loadMoreStatusBusiness,
        workers,
        request,
        business,
        hasNextPage,
        message,
        statusDelete,
        titleBusiness,
        hasNextPageBusiness,
        requestBusiness
      ];
}
