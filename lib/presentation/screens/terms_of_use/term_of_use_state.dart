import 'package:equatable/equatable.dart';
import 'package:phu_tho_mobile/application/enums/load_status.dart';

import '../../../domain/models/response/terms_of_use/terms_of_use_response.dart';

class TermsOfUseState extends Equatable {
  final LoadStatus status;
  final List<TermsOfUseResponse> listData;
  final bool hadNext;
  final String request;
  final bool openSearch;

  const TermsOfUseState({this.status = LoadStatus
      .initial, this.hadNext = false, this.listData = const [], this.request ='', this.openSearch = false});

  TermsOfUseState copyWith({
    LoadStatus? status,
    List<TermsOfUseResponse>? listData,
    bool? hadNext,
    String? request,
    bool? openSearch
  }) {
    return TermsOfUseState(
      status: status ?? this.status,
      hadNext: hadNext ?? this.hadNext,
      listData: listData ?? this.listData,
      request: request ?? this.request,
      openSearch: openSearch ?? this.openSearch
    );
  }

  @override
  // TODO: implement props
  List<Object?> get props => [status, hadNext, listData, request, openSearch];
}