import 'package:either_dart/either.dart';
import 'package:phu_tho_mobile/domain/models/response/banner/banner_response.dart';

abstract class BannerRepository{
  Future<Either<String,List<BannerResponse>>> getBanner();
}