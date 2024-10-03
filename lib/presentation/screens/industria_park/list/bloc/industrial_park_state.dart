import 'package:equatable/equatable.dart';
import 'package:phu_tho_mobile/application/enums/load_status.dart';
import 'package:phu_tho_mobile/domain/models/request/industrial_park/industrial_park_request.dart';
import 'package:phu_tho_mobile/domain/models/response/industrial_park/industrial_park_response.dart';

class IndustrialParkState extends Equatable {
  final IndustrialParkRequest request;
  final List<IndustrialParkResponse> industrialParks;
  final bool hasNextPage;
  final LoadStatus status;
  final LoadStatus statusMore;
  final bool isShowSearch;
  final String searchBy;
  final LoadStatus statusDelete;

  const IndustrialParkState(
      {this.request = const IndustrialParkRequest(),
      this.industrialParks = const [],
      this.hasNextPage = false,
      this.status = LoadStatus.initial,
      this.statusMore = LoadStatus.initial,
      this.searchBy = '',
      this.isShowSearch = false,
      this.statusDelete = LoadStatus.initial});

  IndustrialParkState copyWith(
      {IndustrialParkRequest? request,
      List<IndustrialParkResponse>? industrialParks,
      bool? isShowSearch,
      bool? hasNextPage,
      LoadStatus? status,
      String? searchBy,
      LoadStatus? statusDelete,
      LoadStatus? statusMore}) {
    return IndustrialParkState(
        request: request ?? this.request,
        isShowSearch: isShowSearch ?? this.isShowSearch,
        hasNextPage: hasNextPage ?? this.hasNextPage,
        status: status ?? this.status,
        statusMore: statusMore ?? this.statusMore,
        searchBy: searchBy ?? this.searchBy,
        statusDelete: statusDelete ?? this.statusDelete,
        industrialParks: industrialParks ?? this.industrialParks);
  }

  @override
  List<Object?> get props => [
        request,
        industrialParks,
        searchBy,
        hasNextPage,
        status,
        statusMore,
        statusDelete,
        isShowSearch
      ];
}
