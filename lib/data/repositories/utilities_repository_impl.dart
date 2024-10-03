import 'package:either_dart/src/either.dart';
import 'package:phu_tho_mobile/data/data_sources/api/api_client.dart';
import 'package:phu_tho_mobile/data/data_sources/api/api_response.dart';
import 'package:phu_tho_mobile/di.dart';
import 'package:phu_tho_mobile/domain/models/response/question/question_response.dart';
import 'package:phu_tho_mobile/domain/models/response/info_contact/info_contact_response.dart';
import 'package:phu_tho_mobile/domain/models/response/terms_of_use/terms_of_use_response.dart';
import 'package:phu_tho_mobile/domain/repositories/utilities_repository.dart';

class UtilitiesRepositoryImpl implements UtilitiesRepository {
  final _api = getIt.get<ApiClient>();

  @override
  Future<Either<String, ListDataResponse<TermsOfUseResponse>>> getTermOfUse({String? title}) async{
    try{
      final response = await _api.getTermOfUse(title);
      if(response.status && response.data != null){
        return Right(response.data!);
      }
      return Left(response.message);
    } catch (e) {
      return Left(e.toString());
    }
  }

  @override
  Future<Either<String, InfoContactResponse>> getInfoContact() async {
    try {
      final response = await _api.getInfoContact();
      if (response.status && response.data != null) {
        return Right(response.data!);
      }
      return Left(response.message);
    } catch (e) {
      return Left(e.toString());
    }
  }

  @override
  Future<Either<String, ListDataResponse<QuestionResponse>>> getQuestions({String? title}) async{
    try{
      final response = await _api.getAllQuestion(title);
      if(response.status && response.data != null){
        return Right(response.data!);
      }
      return Left(response.message);
    }
    catch (e){
      return Left(e.toString());
    }
  }

}
