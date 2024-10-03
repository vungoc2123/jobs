import 'package:equatable/equatable.dart';
import 'package:phu_tho_mobile/application/enums/load_status.dart';
import 'package:phu_tho_mobile/application/enums/type_action.dart';
import 'package:phu_tho_mobile/domain/models/response/business/business_response.dart';

class DetailBusinessState extends Equatable {
  final LoadStatus loadStatus;
  final BusinessResponse businessResponse;
  final TypeAction type;

  const DetailBusinessState(
      {this.loadStatus = LoadStatus.initial,
      this.businessResponse = const BusinessResponse(),
      this.type = TypeAction.extract});

  DetailBusinessState copyWith(
      {LoadStatus? loadStatus,
      BusinessResponse? businessResponse,
      TypeAction? type}) {
    return DetailBusinessState(
        loadStatus: loadStatus ?? this.loadStatus,
        businessResponse: businessResponse ?? this.businessResponse,
        type: type ?? this.type);
  }

  @override
  List<Object?> get props => [loadStatus, businessResponse, type];
}
