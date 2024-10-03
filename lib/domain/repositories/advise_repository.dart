import 'package:either_dart/either.dart';
import 'package:phu_tho_mobile/data/data_sources/api/api_response.dart';
import 'package:phu_tho_mobile/domain/models/request/advise/advise_request.dart';
import 'package:phu_tho_mobile/domain/models/response/advise/advise_response.dart';

abstract class AdviseRepository{
  Future<Either<String, ListDataResponse<AdviseResponse>>> getAllAdvise(AdviseRequest request);
}