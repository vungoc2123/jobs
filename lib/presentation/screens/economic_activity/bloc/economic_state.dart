import 'package:equatable/equatable.dart';
import 'package:phu_tho_mobile/application/enums/load_status.dart';
import 'package:phu_tho_mobile/domain/models/common/item_filter.dart';
import 'package:phu_tho_mobile/domain/models/request/economic_activity/economic_activity_request.dart';
import 'package:phu_tho_mobile/domain/models/response/ecocomic_activity/economic_activity_response.dart';
import 'package:phu_tho_mobile/domain/models/response/filter_response/filter_response.dart';

class EconomicState extends Equatable {
  final EconomicActivityRequest request;
  final List<EconomicActivityResponse> economics;
  final bool hasNextPage;
  final LoadStatus status;
  final LoadStatus statusMore;
  final bool isShowSearch;
  final String searchBy;
  final List<FilterResponse> listTypeWork;
  final List<FilterResponse> listTypeEconomic;
  final String typeWork;
  final String typeEconomic;

  const EconomicState(
      {this.request = const EconomicActivityRequest(),
      this.economics = const [],
      this.listTypeWork = const [
        FilterResponse(text: "Tự làm/làm công", value: '')
      ],
      this.listTypeEconomic = const [
        FilterResponse(text: "Loại hình kinh tế", value: '')
      ],
      this.hasNextPage = false,
      this.status = LoadStatus.initial,
      this.statusMore = LoadStatus.initial,
      this.isShowSearch = false,
      this.typeWork = '',
      this.typeEconomic = '',
      this.searchBy = ''});

  EconomicState copyWith(
      {EconomicActivityRequest? request,
      List<EconomicActivityResponse>? economics,
      bool? isShowSearch,
      bool? hasNextPage,
      LoadStatus? status,
      List<FilterResponse>? listTypeWork,
      List<FilterResponse>? listTypeEconomic,
      String? searchBy,
      String? typeWork,
      String? typeEconomic,
      LoadStatus? statusDelete,
      LoadStatus? statusMore}) {
    return EconomicState(
        request: request ?? this.request,
        isShowSearch: isShowSearch ?? this.isShowSearch,
        hasNextPage: hasNextPage ?? this.hasNextPage,
        status: status ?? this.status,
        statusMore: statusMore ?? this.statusMore,
        searchBy: searchBy ?? this.searchBy,
        listTypeWork: listTypeWork ?? this.listTypeWork,
        listTypeEconomic: listTypeEconomic ?? this.listTypeEconomic,
        typeWork: typeWork ?? this.typeWork,
        typeEconomic: typeEconomic ?? this.typeEconomic,
        economics: economics ?? this.economics);
  }

  @override
  List<Object?> get props => [
        request,
        economics,
        searchBy,
        hasNextPage,
        status,
        statusMore,
        isShowSearch,
        listTypeWork,
        listTypeEconomic,
        typeEconomic,
        typeWork
      ];
}
