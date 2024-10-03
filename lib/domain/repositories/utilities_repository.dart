import 'package:either_dart/either.dart';
import 'package:phu_tho_mobile/data/data_sources/api/api_response.dart';
import 'package:phu_tho_mobile/domain/models/response/question/question_response.dart';
import 'package:phu_tho_mobile/domain/models/response/info_contact/info_contact_response.dart';
import 'package:phu_tho_mobile/domain/models/response/terms_of_use/terms_of_use_response.dart';

abstract class UtilitiesRepository{
  Future<Either<String,ListDataResponse<TermsOfUseResponse>>> getTermOfUse({String? title});

  Future<Either<String,ListDataResponse<QuestionResponse>>> getQuestions({String? title});
  Future<Either<String, InfoContactResponse>> getInfoContact();
}
