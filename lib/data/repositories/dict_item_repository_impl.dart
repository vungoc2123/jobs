import 'package:either_dart/either.dart';
import 'package:phu_tho_mobile/data/data_sources/api/api_client.dart';
import 'package:phu_tho_mobile/di.dart';
import 'package:phu_tho_mobile/domain/models/response/filter_response/filter_response.dart';
import 'package:phu_tho_mobile/domain/repositories/dict_item_repository.dart';

class DictItemRepositoryImpl implements DictItemRepository {
  final _api = getIt.get<ApiClient>();

  @override
  Future<Either<String, List<FilterResponse>>> getCommune(
      String idDistrict) async {
    try {
      final response = await _api.getCommune(idDistrict);
      if (response.status && response.data != null) {
        return Right(response.data!);
      }
      return Left(response.message);
    } catch (e) {
      return Left(e.toString());
    }
  }

  @override
  Future<Either<String, List<FilterResponse>>> getDistrict(
      String idProvince) async {
    try {
      final response = await _api.getDistrict(idProvince);
      if (response.status && response.data != null) {
        return Right(response.data!);
      }
      return Left(response.message);
    } catch (e) {
      return Left(e.toString());
    }
  }

  @override
  Future<Either<String, List<FilterResponse>>> getExp() async {
    try {
      final response = await _api.getExp();
      if (response.status && response.data != null) {
        return Right(response.data!);
      }
      return Left(response.message);
    } catch (e) {
      return Left(e.toString());
    }
  }

  @override
  Future<Either<String, List<FilterResponse>>> getGender() async {
    try {
      final response = await _api.getGender();
      if (response.status && response.data != null) {
        return Right(response.data!);
      }
      return Left(response.message);
    } catch (e) {
      return Left(e.toString());
    }
  }

  @override
  Future<Either<String, List<FilterResponse>>> getJob() async {
    try {
      final response = await _api.getJob();
      if (response.status && response.data != null) {
        return Right(response.data!);
      }
      return Left(response.message);
    } catch (e) {
      return Left(e.toString());
    }
  }

  @override
  Future<Either<String, List<FilterResponse>>> getLevel() async {
    try {
      final response = await _api.getLevel();
      if (response.status && response.data != null) {
        return Right(response.data!);
      }
      return Left(response.message);
    } catch (e) {
      return Left(e.toString());
    }
  }

  @override
  Future<Either<String, List<FilterResponse>>> getPosition() async {
    try {
      final response = await _api.getPosition();
      if (response.status && response.data != null) {
        return Right(response.data!);
      }
      return Left(response.message);
    } catch (e) {
      return Left(e.toString());
    }
  }

  @override
  Future<Either<String, List<FilterResponse>>> getProvince() async {
    try {
      final response = await _api.getProvince();
      if (response.status && response.data != null) {
        return Right(response.data!);
      }
      return Left(response.message);
    } catch (e) {
      return Left(e.toString());
    }
  }

  @override
  Future<Either<String, List<FilterResponse>>> getSalary() async {
    try {
      final response = await _api.getSalary();
      if (response.status && response.data != null) {
        return Right(response.data!);
      }
      return Left(response.message);
    } catch (e) {
      return Left(e.toString());
    }
  }

  @override
  Future<Either<String, List<FilterResponse>>> getStatusBusiness() async {
    try {
      final response = await _api.getStatusBusiness();
      if (response.status && response.data != null) {
        return Right(response.data!);
      }
      return Left(response.message);
    } catch (e) {
      return Left(e.toString());
    }
  }

  @override
  Future<Either<String, List<FilterResponse>>> getAreas() async {
    try {
      final response = await _api.getArea();
      if (response.status && response.data != null) {
        return Right(response.data!);
      }
      return Left(response.message);
    } catch (e) {
      return Left(e.toString());
    }
  }

  @override
  Future<Either<String, List<FilterResponse>>> getTypeAccount() async {
    try {
      final response = await _api.getTypeAccount();
      if (response.status && response.data != null) {
        return Right(response.data!);
      }
      return Left(response.message);
    } catch (e) {
      return Left(e.toString());
    }
  }

  @override
  Future<Either<String, List<FilterResponse>>> getTypeEconomic() async {
    try {
      final response = await _api.getTypeEconomic();
      if (response.status && response.data != null) {
        return Right(response.data!);
      }
      return Left(response.message);
    } catch (e) {
      return Left(e.toString());
    }
  }

  @override
  Future<Either<String, List<FilterResponse>>> getTypeWork() async {
    try {
      final response = await _api.getTypeWork();
      if (response.status && response.data != null) {
        return Right(response.data!);
      }
      return Left(response.message);
    } catch (e) {
      return Left(e.toString());
    }
  }

  @override
  Future<Either<String, List<FilterResponse>>> getEthnicities() async {
    try {
      final response = await _api.getEthnicities();
      if (response.status && response.data != null) {
        return Right(response.data!);
      }
      return Left(response.message);
    } catch (e) {
      return Left(e.toString());
    }
  }

  @override
  Future<Either<String, List<FilterResponse>>>
      getRelationShipWithHeader() async {
    try {
      final response = await _api.getRelationShipWithHeader();
      if (response.status && response.data != null) {
        return Right(response.data!);
      }
      return Left(response.message);
    } catch (e) {
      return Left(e.toString());
    }
  }

  @override
  Future<Either<String, List<FilterResponse>>> getGendersInMember() async {
    try {
      final response = await _api.getGenderInMember();
      if (response.status && response.data != null) {
        return Right(response.data!);
      }
      return Left(response.message);
    } catch (e) {
      return Left(e.toString());
    }
  }
}
