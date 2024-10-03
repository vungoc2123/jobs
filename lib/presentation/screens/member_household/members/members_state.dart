import 'package:equatable/equatable.dart';
import 'package:phu_tho_mobile/application/enums/load_status.dart';
import 'package:phu_tho_mobile/domain/models/request/member_household/member_household_request.dart';
import 'package:phu_tho_mobile/domain/models/response/filter_response/filter_response.dart';
import 'package:phu_tho_mobile/domain/models/response/member_household/member_household_response.dart';

class MembersState extends Equatable {
  final LoadStatus loadStatus;
  final LoadStatus loadMore;
  final LoadStatus loadRelationDistrictEthnicities;
  final LoadStatus loadCommunes;
  final List<MemberHouseholdResponse> members;
  final MemberHouseholdRequest request;
  final bool hasNextPage;
  final List<FilterResponse> relationshipsWithHeader;
  final List<FilterResponse> ethnicities;
  final List<FilterResponse> districts;
  final List<FilterResponse> communes;
  final List<FilterResponse> genders;
  final FilterResponse relationShipFilter;
  final FilterResponse ethnicityFilter;
  final FilterResponse districtFilter;
  final FilterResponse communesFilter;
  final FilterResponse gendersFilter;

  const MembersState({
    this.loadStatus = LoadStatus.initial,
    this.loadMore = LoadStatus.initial,
    this.loadRelationDistrictEthnicities = LoadStatus.initial,
    this.loadCommunes = LoadStatus.initial,
    this.members = const [],
    this.request = const MemberHouseholdRequest(pageSize: 100),
    this.hasNextPage = true,
    this.communes = const [],
    this.districts = const [],
    this.ethnicities = const [],
    this.relationshipsWithHeader = const [],
    this.genders = const [],
    this.relationShipFilter =
        const FilterResponse(text: "Quan hệ với chủ hộ", value: ""),
    this.communesFilter = const FilterResponse(text: "Xã", value: ""),
    this.ethnicityFilter = const FilterResponse(text: "Dân tộc", value: ""),
    this.districtFilter = const FilterResponse(text: "Huyện", value: ""),
    this.gendersFilter = const FilterResponse(text: "Giới tính", value: ""),
  });

  MembersState copyWith({
    LoadStatus? loadStatus,
    LoadStatus? loadMore,
    LoadStatus? loadRelationDistrictEthnicities,
    LoadStatus? loadCommunes,
    List<MemberHouseholdResponse>? members,
    MemberHouseholdRequest? request,
    bool? hasNextPage,
    List<FilterResponse>? relationshipsWithHeader,
    List<FilterResponse>? ethnicities,
    List<FilterResponse>? districts,
    List<FilterResponse>? communes,
    List<FilterResponse>? genders,
    FilterResponse? relationShipFilter,
    FilterResponse? ethnicityFilter,
    FilterResponse? districtFilter,
    FilterResponse? communesFilter,
    FilterResponse? gendersFilter,
  }) {
    return MembersState(
        loadStatus: loadStatus ?? this.loadStatus,
        loadMore: loadMore ?? this.loadMore,
        loadRelationDistrictEthnicities: loadRelationDistrictEthnicities ??
            this.loadRelationDistrictEthnicities,
        loadCommunes: loadCommunes ?? this.loadCommunes,
        members: members ?? this.members,
        request: request ?? this.request,
        hasNextPage: hasNextPage ?? this.hasNextPage,
        districts: districts ?? this.districts,
        communes: communes ?? this.communes,
        ethnicities: ethnicities ?? this.ethnicities,
        relationshipsWithHeader:
            relationshipsWithHeader ?? this.relationshipsWithHeader,
        genders: genders ?? this.genders,
        districtFilter: districtFilter ?? this.districtFilter,
        communesFilter: communesFilter ?? this.communesFilter,
        ethnicityFilter: ethnicityFilter ?? this.ethnicityFilter,
        relationShipFilter: relationShipFilter ?? this.relationShipFilter,
        gendersFilter: gendersFilter ?? this.gendersFilter);
  }

  @override
  List<Object?> get props => [
        loadMore,
        loadStatus,
        members,
        request,
        hasNextPage,
        loadRelationDistrictEthnicities,
        loadCommunes,
        communes,
        districts,
        relationshipsWithHeader,
        ethnicities,
        relationShipFilter,
        districtFilter,
        communesFilter,
        ethnicityFilter,
        gendersFilter,
        genders
      ];
}
