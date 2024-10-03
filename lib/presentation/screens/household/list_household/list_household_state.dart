import 'package:equatable/equatable.dart';
import 'package:phu_tho_mobile/application/enums/load_status.dart';
import 'package:phu_tho_mobile/domain/models/request/household/household_request.dart';
import 'package:phu_tho_mobile/domain/models/response/filter_response/filter_response.dart';
import 'package:phu_tho_mobile/domain/models/response/household/household_response.dart';

class HouseHoldsState extends Equatable {
  final LoadStatus loadStatus;
  final LoadStatus loadMoreStatus;
  final LoadStatus loadAreas;
  final LoadStatus loadDistrictStatus;
  final LoadStatus loadCommuneStatus;
  final HouseholdRequest request;
  final List<HouseholdResponse> households;
  final List<FilterResponse> areas;
  final List<FilterResponse> districts;
  final List<FilterResponse> communes;
  final FilterResponse filterResponseArea;
  final FilterResponse filterResponseDistrict;
  final FilterResponse filterResponseCommunes;
  final bool hasNextPage;

  const HouseHoldsState(
      {this.loadStatus = LoadStatus.initial,
      this.loadMoreStatus = LoadStatus.initial,
      this.loadAreas = LoadStatus.initial,
      this.loadDistrictStatus = LoadStatus.initial,
      this.loadCommuneStatus = LoadStatus.initial,
      this.request = const HouseholdRequest(),
      this.hasNextPage = true,
      this.households = const [],
      this.areas = const [],
      this.districts = const [],
      this.communes = const [],
      this.filterResponseArea =
          const FilterResponse(text: "Khu vực", value: ""),
      this.filterResponseDistrict =
          const FilterResponse(text: "Quận, huyện", value: ""),
      this.filterResponseCommunes =
          const FilterResponse(text: "Tên xã", value: "")});

  HouseHoldsState copyWith({
    LoadStatus? loadStatus,
    LoadStatus? loadMoreStatus,
    LoadStatus? loadAreas,
    LoadStatus? loadCommuneStatus,
    LoadStatus? loadDistrictStatus,
    HouseholdRequest? request,
    List<HouseholdResponse>? households,
    List<FilterResponse>? areas,
    List<FilterResponse>? communes,
    List<FilterResponse>? districts,
    bool? hasNextPage,
    FilterResponse? filterResponseArea,
    FilterResponse? filterResponseDistrict,
    FilterResponse? filterResponseCommunes,
  }) {
    return HouseHoldsState(
        loadStatus: loadStatus ?? this.loadStatus,
        loadMoreStatus: loadMoreStatus ?? this.loadMoreStatus,
        loadCommuneStatus: loadCommuneStatus ?? this.loadCommuneStatus,
        loadDistrictStatus: loadDistrictStatus ?? this.loadDistrictStatus,
        loadAreas: loadAreas ?? this.loadAreas,
        request: request ?? this.request,
        hasNextPage: hasNextPage ?? this.hasNextPage,
        households: households ?? this.households,
        areas: areas ?? this.areas,
        filterResponseArea: filterResponseArea ?? this.filterResponseArea,
        communes: communes ?? this.communes,
        districts: districts ?? this.districts,
        filterResponseCommunes:
            filterResponseCommunes ?? this.filterResponseCommunes,
        filterResponseDistrict:
            filterResponseDistrict ?? this.filterResponseDistrict);
  }

  @override
  List<Object?> get props => [
        loadMoreStatus,
        loadStatus,
        request,
        hasNextPage,
        households,
        loadAreas,
        areas,
        filterResponseArea,
        loadDistrictStatus,
        loadCommuneStatus,
        districts,
        communes,
        filterResponseDistrict,
        filterResponseCommunes
      ];
}
