import 'package:equatable/equatable.dart';
import 'package:phu_tho_mobile/application/enums/load_status.dart';
import 'package:phu_tho_mobile/domain/models/request/business/business_request.dart';
import 'package:phu_tho_mobile/domain/models/response/business/business_response.dart';

class DetailIndustrialParkState extends Equatable {
  final LoadStatus loadStatus;
  final LoadStatus loadMoreStatus;
  final BusinessRequest request;
  final bool hasNextPage;
  final List<BusinessResponse> business;

  const DetailIndustrialParkState(
      {this.business = const [],
      this.hasNextPage = false,
      this.loadMoreStatus = LoadStatus.initial,
      this.request = const BusinessRequest(),
      this.loadStatus = LoadStatus.initial});

  DetailIndustrialParkState copyWith(
      {List<BusinessResponse>? business,
      BusinessRequest? request,
      bool? hasNextPage,
      LoadStatus? loadMoreStatus,
      LoadStatus? loadStatus}) {
    return DetailIndustrialParkState(
        business: business ?? this.business,
        request: request ?? this.request,
        loadStatus: loadStatus ?? this.loadStatus,
        hasNextPage: hasNextPage ?? this.hasNextPage,
        loadMoreStatus: loadMoreStatus ?? this.loadMoreStatus);
  }

  @override
  List<Object?> get props =>
      [business, request, loadStatus, hasNextPage, loadMoreStatus];
}
