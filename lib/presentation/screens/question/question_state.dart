import 'package:equatable/equatable.dart';
import 'package:phu_tho_mobile/application/enums/load_status.dart';
import 'package:phu_tho_mobile/domain/models/response/question/question_response.dart';

class QuestionState extends Equatable {
  final LoadStatus status;
  final List<QuestionResponse> questions;
  final bool hadNext;
  final String request;

  const QuestionState(
      {this.status = LoadStatus.initial,
      this.hadNext = false,
      this.questions = const [],
      this.request = ''});

  QuestionState copyWith(
      {LoadStatus? status, List<QuestionResponse>? questions, bool? hadNext, String? request}) {
    return QuestionState(
        status: status ?? this.status,
        hadNext: hadNext ?? this.hadNext,
        questions: questions ?? this.questions,
        request: request ?? this.request
    );
  }

  @override
  List<Object?> get props => [status, questions, hadNext, request];
}
