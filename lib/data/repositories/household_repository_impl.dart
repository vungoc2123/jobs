import 'package:either_dart/either.dart';
import 'package:phu_tho_mobile/data/data_sources/api/api_client.dart';
import 'package:phu_tho_mobile/data/data_sources/api/api_response.dart';
import 'package:phu_tho_mobile/di.dart';
import 'package:phu_tho_mobile/domain/models/request/household/household_request.dart';
import 'package:phu_tho_mobile/domain/models/request/member_household/member_household_request.dart';
import 'package:phu_tho_mobile/domain/models/response/household/household_response.dart';
import 'package:phu_tho_mobile/domain/models/response/member_household/member_household_response.dart';
import 'package:phu_tho_mobile/domain/repositories/household_repository.dart';

class HouseHoldRepositoryImpl extends HouseholdRepository {
  final _api = getIt.get<ApiClient>();

  @override
  Future<Either<String, ListDataResponse<HouseholdResponse>>> getHouseholds(
      HouseholdRequest request) async {
    try {
      final response = await _api.getHouseholds(request);
      if (response.status && response.data != null) {
        return Right(response.data!);
      }
      return Left(response.message);
    } catch (e) {
      return Left(e.toString());
    }
  }

  @override
  Future<Either<String, ListDataResponse<MemberHouseholdResponse>>>
      getMemberOfHousehold(MemberHouseholdRequest request) async {
    try {
      final response = await _api.getMemberHouseholds(request);
      if (response.status && response.data != null) {
        return Right(response.data!);
      }
      return Left(response.message);
    } catch (e) {
      return Left(e.toString());
    }
  }

  @override
  Future<Either<String, MemberHouseholdResponse>> getDetailMember(
      int id) async {
    try {
      final response = await _api.getDetailMemberHousehold(id);
      if (response.status && response.data != null) {
        return Right(response.data!);
      }
      return Left(response.message);
    } catch (e) {
      return Left(e.toString());
    }
  }
}
