import 'package:equatable/equatable.dart';
import 'package:phu_tho_mobile/application/enums/load_status.dart';
import 'package:phu_tho_mobile/domain/models/request/advise/advise_request.dart';
import 'package:phu_tho_mobile/domain/models/response/advise/advise_response.dart';

import '../../../application/enums/searchField.dart';

class ConsultingState extends Equatable {
  final LoadStatus status;
  final List<AdviseResponse> advises;
  final bool hadNextPage;
  final AdviseRequest request;

  final SearchField field;
  final bool openSearch;

  const ConsultingState(
      {this.request = const AdviseRequest(),
      this.advises = const [],
      this.openSearch = false,
      this.hadNextPage = false,
      this.field = SearchField.unknown,
      this.status = LoadStatus.initial});

  ConsultingState copyWith(
      {LoadStatus? status,
      List<AdviseResponse>? advises,
      bool? hadNextPage,
      bool? openSearch,
      SearchField? field,
      AdviseRequest? request}) {
    return ConsultingState(
        request: request ?? this.request,
        field: field ?? this.field,
        openSearch: openSearch ?? this.openSearch,
        status: status ?? this.status,
        advises: advises ?? this.advises,
        hadNextPage: hadNextPage ?? this.hadNextPage);
  }

  @override
  // TODO: implement props
  List<Object?> get props =>
      [request, status, advises, hadNextPage, openSearch, field];
}
