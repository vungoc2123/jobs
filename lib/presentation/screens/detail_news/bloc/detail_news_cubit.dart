import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:phu_tho_mobile/application/enums/load_status.dart';
import 'package:phu_tho_mobile/di.dart';
import 'package:phu_tho_mobile/domain/repositories/news_repository.dart';
import 'package:phu_tho_mobile/presentation/screens/detail_news/bloc/detail_news_state.dart';

class DetailNewsCubit extends Cubit<DetailNewsState> {
  DetailNewsCubit() : super(const DetailNewsState());
  final repo = getIt.get<NewsRepository>();

  Future<void> getNewsSame(int id) async {
    try {
      emit(state.copyWith(status: LoadStatus.loading));
      final response = await repo.getNewsSame(id, 10);
      if (response.isRight) {
        emit(state.copyWith(
            status: LoadStatus.success,
            listSame: response.right));
        return;
      }
      emit(state.copyWith(status: LoadStatus.failure));
      return;
    } catch (e) {
      emit(state.copyWith(status: LoadStatus.failure));
      return;
    }
  }
}
