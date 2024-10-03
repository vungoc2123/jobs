import 'package:equatable/equatable.dart';
import 'package:phu_tho_mobile/application/enums/load_status.dart';
import 'package:phu_tho_mobile/domain/models/request/forgot_password/forgot_password_request.dart';

class ForgotPasswordState extends Equatable {
  final LoadStatus loadStatus;
  final ForgotPasswordRequest request;
  final String message;

  const ForgotPasswordState(
      {this.loadStatus = LoadStatus.initial,
      this.request = const ForgotPasswordRequest(),
      this.message = ''});

  ForgotPasswordState copyWith(
      {LoadStatus? loadStatus,
      ForgotPasswordRequest? request,
      String? message}) {
    return ForgotPasswordState(
        loadStatus: loadStatus ?? this.loadStatus,
        request: request ?? this.request,
        message: message ?? this.message);
  }

  @override
  List<Object?> get props => [loadStatus, request, message];
}
