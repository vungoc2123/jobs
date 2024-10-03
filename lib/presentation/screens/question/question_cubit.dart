import 'package:bloc/bloc.dart';
import 'package:phu_tho_mobile/application/enums/load_status.dart';
import 'package:phu_tho_mobile/di.dart';
import 'package:phu_tho_mobile/domain/repositories/utilities_repository.dart';
import 'package:phu_tho_mobile/presentation/screens/question/question_state.dart';

class QuestionCubit extends Cubit<QuestionState> {
  QuestionCubit() : super(const QuestionState());

  final repo = getIt.get<UtilitiesRepository>();

  Future<void> getAllQuestion() async {
    try {
      emit(state.copyWith(status: LoadStatus.loading));
      final response = await repo.getQuestions(title: state.request);
      if (response.isRight) {
        emit(state.copyWith(status: LoadStatus.success,
            questions: response.right.listItem,
            hadNext: response.right.hasNextPage));
        return;
      }
      emit(state.copyWith(status: LoadStatus.failure));
    }catch(e){
      emit(state.copyWith(status: LoadStatus.failure));
    }
  }
  Future<void> getQuestionMore() async {
    if(state.hadNext){
      try {
        emit(state.copyWith(status: LoadStatus.loading));
        final response = await repo.getQuestions(title: state.request);
        if (response.isRight) {
          emit(state.copyWith(status: LoadStatus.success,
              questions: [...response.right.listItem,...state.questions],
              hadNext: response.right.hasNextPage));
          return;
        }
        emit(state.copyWith(status: LoadStatus.failure));
      }catch(e){
        emit(state.copyWith(status: LoadStatus.failure));
      }
    }
  }

  void changeRequest(String values) {
    emit(state.copyWith(request: values));
  }
}