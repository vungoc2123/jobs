import 'package:equatable/equatable.dart';
import 'package:phu_tho_mobile/application/enums/load_status.dart';
import 'package:phu_tho_mobile/domain/models/response/news/news_response.dart';

class DetailNewsState extends Equatable {
  final LoadStatus status;
  final List<NewsResponse> listSame;

  const DetailNewsState(
      {this.status = LoadStatus.initial, this.listSame = const []});

  DetailNewsState copyWith({
    LoadStatus? status,
    List<NewsResponse>? listSame,
  }) {
    return DetailNewsState(
        status: status ?? this.status, listSame: listSame ?? this.listSame);
  }

  @override
  List<Object?> get props => [status, listSame];
}
