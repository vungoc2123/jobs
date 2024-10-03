import 'package:equatable/equatable.dart';
import 'package:phu_tho_mobile/application/enums/load_status.dart';
import 'package:phu_tho_mobile/domain/models/response/info_contact/info_contact_response.dart';

class InfoContactState extends Equatable {
  final LoadStatus loadStatus;
  final InfoContactResponse infoContactResponse;

  const InfoContactState(
      {this.loadStatus = LoadStatus.initial,
      this.infoContactResponse = const InfoContactResponse()});

  InfoContactState copyWith(
      {LoadStatus? loadStatus, InfoContactResponse? infoContactResponse}) {
    return InfoContactState(
        loadStatus: loadStatus ?? this.loadStatus,
        infoContactResponse: infoContactResponse ?? this.infoContactResponse);
  }

  @override
  List<Object?> get props => [loadStatus, infoContactResponse];
}
