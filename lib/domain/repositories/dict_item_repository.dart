import 'package:either_dart/either.dart';
import 'package:phu_tho_mobile/domain/models/response/filter_response/filter_response.dart';

abstract class DictItemRepository {
  Future<Either<String, List<FilterResponse>>> getProvince();

  Future<Either<String, List<FilterResponse>>> getDistrict(String idProvince);

  Future<Either<String, List<FilterResponse>>> getCommune(String idDistrict);

  Future<Either<String, List<FilterResponse>>> getGender();

  Future<Either<String, List<FilterResponse>>> getExp();

  Future<Either<String, List<FilterResponse>>> getLevel();

  Future<Either<String, List<FilterResponse>>> getSalary();

  Future<Either<String, List<FilterResponse>>> getJob();

  Future<Either<String, List<FilterResponse>>> getPosition();

  Future<Either<String, List<FilterResponse>>> getStatusBusiness();

  Future<Either<String, List<FilterResponse>>> getAreas();

  Future<Either<String, List<FilterResponse>>> getTypeAccount();


  Future<Either<String, List<FilterResponse>>> getTypeEconomic();

  Future<Either<String, List<FilterResponse>>> getTypeWork();

  Future<Either<String, List<FilterResponse>>> getRelationShipWithHeader();

  Future<Either<String, List<FilterResponse>>> getEthnicities();

  Future<Either<String, List<FilterResponse>>> getGendersInMember();
}
