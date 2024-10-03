import 'package:equatable/equatable.dart';
import 'package:phu_tho_mobile/application/enums/load_status.dart';
import 'package:phu_tho_mobile/domain/models/request/change_password/change_password_request.dart';

class ChangePasswordState extends Equatable {
  final LoadStatus loadStatus;
  final ChangePasswordRequest request;
  final String message;

  const ChangePasswordState(
      {this.loadStatus = LoadStatus.initial,
      this.request = const ChangePasswordRequest(),
      this.message = ''});

  ChangePasswordState copyWith(
      {LoadStatus? loadStatus,
      ChangePasswordRequest? request,
      String? message}) {
    return ChangePasswordState(
        loadStatus: loadStatus ?? this.loadStatus,
        request: request ?? this.request,
        message: message ?? this.message);
  }

  @override
  List<Object?> get props => [loadStatus, request, message];
}
