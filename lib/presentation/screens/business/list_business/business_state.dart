import 'package:easy_localization/easy_localization.dart';
import 'package:equatable/equatable.dart';
import 'package:phu_tho_mobile/application/enums/load_status.dart';
import 'package:phu_tho_mobile/application/enums/type_action.dart';
import 'package:phu_tho_mobile/domain/models/request/business/business_request.dart';
import 'package:phu_tho_mobile/domain/models/response/business/business_response.dart';
import 'package:phu_tho_mobile/domain/models/response/filter_response/filter_response.dart';

class BusinessState extends Equatable {
  final LoadStatus loadStatus;
  final LoadStatus loadMoreStatus;
  final LoadStatus deleteStatus;
  final BusinessRequest request;
  final bool hasNextPage;
  final List<BusinessResponse> business;
  final TypeAction type;
  final String message;
  final List<FilterResponse> statusBusiness;
  final LoadStatus loadStatusBusiness;
  final FilterResponse filterResponse;

  const BusinessState(
      {this.request = const BusinessRequest(),
      this.loadStatus = LoadStatus.initial,
      this.loadMoreStatus = LoadStatus.initial,
      this.deleteStatus = LoadStatus.initial,
      this.hasNextPage = true,
      this.business = const [],
      this.type = TypeAction.extract,
      this.message = "",
      this.statusBusiness = const [],
      this.loadStatusBusiness = LoadStatus.initial,
      this.filterResponse =
          const FilterResponse(text: "Trạng thái", value: "")});

  BusinessState copyWith(
      {LoadStatus? loadStatus,
      LoadStatus? loadMoreStatus,
      LoadStatus? deleteStatus,
      BusinessRequest? request,
      List<BusinessResponse>? business,
      bool? hasNextPage,
      TypeAction? type,
      String? message,
      LoadStatus? loadStatusBusiness,
      List<FilterResponse>? statusBusiness,
      FilterResponse? filterResponse}) {
    return BusinessState(
        loadStatus: loadStatus ?? this.loadStatus,
        loadMoreStatus: loadMoreStatus ?? this.loadMoreStatus,
        deleteStatus: deleteStatus ?? this.deleteStatus,
        request: request ?? this.request,
        business: business ?? this.business,
        hasNextPage: hasNextPage ?? this.hasNextPage,
        type: type ?? this.type,
        message: message ?? this.message,
        loadStatusBusiness: loadStatusBusiness ?? this.loadStatusBusiness,
        statusBusiness: statusBusiness ?? this.statusBusiness,
        filterResponse: filterResponse ?? this.filterResponse);
  }

  @override
  List<Object?> get props => [
        loadStatus,
        loadMoreStatus,
        request,
        hasNextPage,
        business,
        type,
        deleteStatus,
        message,
        loadStatusBusiness,
        statusBusiness,
        filterResponse
      ];
}
