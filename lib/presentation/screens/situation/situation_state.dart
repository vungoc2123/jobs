import 'package:equatable/equatable.dart';
import 'package:phu_tho_mobile/application/enums/load_status.dart';
import 'package:phu_tho_mobile/domain/models/request/service/service_request.dart';

import '../../../domain/models/response/service/business_service.dart';

class SituationState extends Equatable {
  final LoadStatus status;
  final List<BusinessServiceResponse> listData;
  final ServiceRequest request;
  final bool hadNextPage;

  final bool openSearch;
  final int searchField;

  const SituationState({this.request = const ServiceRequest(taxCode: '',address: '',nameBusiness: ''),
    this.status = LoadStatus.initial,
    this.hadNextPage = false,
    this.searchField = 0,
    this.openSearch = false,
    this.listData = const []});

  SituationState copyWith({LoadStatus? status, List<
      BusinessServiceResponse>? listData, ServiceRequest? request, bool? hadNextPage, bool? openSearch, int? searchField}) {
    return SituationState(request: request ?? this.request,
        status: status ?? this.status,
        openSearch: openSearch ?? this.openSearch,
        searchField: searchField ?? this.searchField,
        hadNextPage: hadNextPage ?? this.hadNextPage,
        listData: listData ?? this.listData);
  }

  @override
  // TODO: implement props
  List<Object?> get props => [status,request,listData,hadNextPage, openSearch, searchField];


}
