import 'package:bloc/bloc.dart';
import 'package:phu_tho_mobile/application/enums/load_status.dart';
import 'package:phu_tho_mobile/di.dart';
import 'package:phu_tho_mobile/domain/repositories/utilities_repository.dart';
import 'package:phu_tho_mobile/presentation/screens/terms_of_use/term_of_use_state.dart';

class TermsOfUseCubit extends Cubit<TermsOfUseState> {
  TermsOfUseCubit() : super(const TermsOfUseState());

  final repo = getIt.get<UtilitiesRepository>();

  Future<void> getTermsOfUse() async {
    try {
      emit(state.copyWith(status: LoadStatus.loading));
      final response = await repo.getTermOfUse(title: state.request);
      if (response.isRight) {
        emit(state.copyWith(status: LoadStatus.success,
            listData: response.right.listItem,
            hadNext: response.right.hasNextPage));
        return;
      }
      emit(state.copyWith(status: LoadStatus.failure));
    }catch (e){
      emit(state.copyWith(status: LoadStatus.failure));
      return;
    }
  }

  Future<void> getTermsOfUseMore() async {
    if(state.hadNext){
      try {
        emit(state.copyWith(status: LoadStatus.loading,));
        final response = await repo.getTermOfUse(title: state.request);
        if (response.isRight) {
          emit(state.copyWith(status: LoadStatus.success,
              listData: [...response.right.listItem,...state.listData],
              hadNext: response.right.hasNextPage));
          return;
        }
        emit(state.copyWith(status: LoadStatus.failure));
      }catch (e){
        emit(state.copyWith(status: LoadStatus.failure));
        return;
      }
    }
  }

  void changeRequest(String title){
    emit(state.copyWith(request: title));
  }

  void openSearch(){
    emit(state.copyWith(openSearch: !state.openSearch));
  }
}
