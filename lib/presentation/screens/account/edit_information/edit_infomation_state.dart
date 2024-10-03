import 'package:equatable/equatable.dart';
import 'package:phu_tho_mobile/application/enums/load_status.dart';
import 'package:phu_tho_mobile/domain/models/request/edit_information/edit_information_request.dart';

class EditInformationState extends Equatable {
  final LoadStatus loadStatus;
  final EditInformationRequest request;
  final String message;

  const EditInformationState(
      {this.loadStatus = LoadStatus.initial,
      this.request = const EditInformationRequest(),
      this.message = ''});

  EditInformationState copyWith(
      {LoadStatus? loadStatus,
      EditInformationRequest? request,
      String? message}) {
    return EditInformationState(
        loadStatus: loadStatus ?? this.loadStatus,
        request: request ?? this.request,
        message: message ?? this.message);
  }

  @override
  List<Object?> get props => [loadStatus, request, message];
}
