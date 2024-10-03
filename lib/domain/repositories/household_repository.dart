import 'package:either_dart/either.dart';
import 'package:phu_tho_mobile/data/data_sources/api/api_response.dart';
import 'package:phu_tho_mobile/domain/models/request/household/household_request.dart';
import 'package:phu_tho_mobile/domain/models/request/member_household/member_household_request.dart';
import 'package:phu_tho_mobile/domain/models/response/household/household_response.dart';
import 'package:phu_tho_mobile/domain/models/response/member_household/member_household_response.dart';

abstract class HouseholdRepository {
  Future<Either<String, ListDataResponse<HouseholdResponse>>> getHouseholds(
      HouseholdRequest request);

  Future<Either<String, ListDataResponse<MemberHouseholdResponse>>>
      getMemberOfHousehold(MemberHouseholdRequest request);

  Future<Either<String,MemberHouseholdResponse>> getDetailMember(int id);
}
