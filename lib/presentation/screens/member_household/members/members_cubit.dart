import 'package:either_dart/either.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:phu_tho_mobile/application/enums/load_status.dart';
import 'package:phu_tho_mobile/di.dart';
import 'package:phu_tho_mobile/domain/models/common/item_filter.dart';
import 'package:phu_tho_mobile/domain/models/request/member_household/member_household_request.dart';
import 'package:phu_tho_mobile/domain/models/response/filter_response/filter_response.dart';
import 'package:phu_tho_mobile/domain/repositories/dict_item_repository.dart';
import 'package:phu_tho_mobile/domain/repositories/household_repository.dart';
import 'package:phu_tho_mobile/presentation/screens/member_household/members/members_state.dart';

class MembersCubit extends Cubit<MembersState> {
  MembersCubit() : super(const MembersState());
  final _repo = getIt.get<HouseholdRepository>();
  final _repoDict = getIt.get<DictItemRepository>();

  Future<void> getMembers() async {
    try {
      emit(state.copyWith(loadStatus: LoadStatus.loading));
      final response = await _repo.getMemberOfHousehold(state.request);
      if (response.isRight) {
        emit(state.copyWith(
            loadStatus: LoadStatus.success,
            members: response.right.listItem,
            hasNextPage: response.right.hasNextPage));
        return;
      }
      emit(state.copyWith(loadStatus: LoadStatus.failure));
    } catch (e) {
      emit(state.copyWith(loadStatus: LoadStatus.failure));
    }
  }

  Future<void> getMoreMembers() async {
    try {
      if (!state.hasNextPage || state.loadStatus == LoadStatus.loading) {
        return;
      }
      emit(state.copyWith(loadMore: LoadStatus.loading));
      onChangeRequest(
          state.request.copyWith(pageIndex: state.request.pageIndex + 1));
      final response = await _repo.getMemberOfHousehold(state.request);
      if (response.isRight) {
        emit(state.copyWith(
            loadMore: LoadStatus.success,
            members: [...state.members, ...response.right.listItem],
            hasNextPage: response.right.hasNextPage));
        return;
      }
      emit(state.copyWith(loadMore: LoadStatus.failure));
    } catch (e) {
      emit(state.copyWith(loadMore: LoadStatus.failure));
    }
  }

  void onChangeRequest(MemberHouseholdRequest request) {
    emit(state.copyWith(request: request));
  }

  Future<void> getDropDownStart() async {
    try {
      emit(state.copyWith(loadRelationDistrictEthnicities: LoadStatus.loading));
      final relations = await _repoDict.getRelationShipWithHeader();
      final ethnicities = await _repoDict.getEthnicities();
      final districts = await _repoDict.getDistrict("25");
      final genders = await _repoDict.getGendersInMember();
      if (relations.isRight &&
          ethnicities.isRight &&
          districts.isRight &&
          genders.isRight) {
        emit(state.copyWith(
            loadRelationDistrictEthnicities: LoadStatus.success,
            relationshipsWithHeader: relations.right,
            ethnicities: ethnicities.right,
            districts: districts.right,
            genders: genders.right));
        return;
      }
      emit(state.copyWith(loadRelationDistrictEthnicities: LoadStatus.failure));
    } catch (e) {
      emit(state.copyWith(loadRelationDistrictEthnicities: LoadStatus.failure));
    }
  }

  void changeRelationShipFilter(ItemFilter item) {
    emit(state.copyWith(
        relationShipFilter:
            FilterResponse(value: item.getValues(), text: item.getTitle())));
  }

  void changeDistrictFilter(ItemFilter item) {
    emit(state.copyWith(
        districtFilter:
            FilterResponse(value: item.getValues(), text: item.getTitle())));
  }

  void changeEthnicityFilter(ItemFilter item) {
    emit(state.copyWith(
        ethnicityFilter:
            FilterResponse(value: item.getValues(), text: item.getTitle())));
  }

  void changeCommuneFilter(ItemFilter item) {
    emit(state.copyWith(
        communesFilter:
            FilterResponse(value: item.getValues(), text: item.getTitle())));
  }

  void changeGenderFilter(ItemFilter item) {
    emit(state.copyWith(
        gendersFilter:
            FilterResponse(value: item.getValues(), text: item.getTitle())));
  }

  void resetFilter() {
    emit(state.copyWith(
      communesFilter: const FilterResponse(text: "Xã", value: ""),
      relationShipFilter:
          const FilterResponse(text: "Quan hệ với chủ hộ", value: ""),
      ethnicityFilter: const FilterResponse(text: "Dân tộc", value: ""),
      districtFilter: const FilterResponse(text: "Huyện", value: ""),
      gendersFilter: const FilterResponse(text: "Giới tính", value: ""),
    ));
  }

  Future<void> getCommunes(String idDistrict) async {
    try {
      emit(state.copyWith(loadCommunes: LoadStatus.loading));
      final response = await _repoDict.getCommune(idDistrict);
      if (response.isRight) {
        emit(state.copyWith(
            loadCommunes: LoadStatus.success, communes: response.right));
        return;
      }
      emit(state.copyWith(loadCommunes: LoadStatus.failure));
    } catch (e) {
      emit(state.copyWith(loadCommunes: LoadStatus.failure));
    }
  }
}
