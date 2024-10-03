import 'package:equatable/equatable.dart';
import 'package:phu_tho_mobile/application/enums/load_status.dart';
import 'package:phu_tho_mobile/domain/models/request/login_request/login_request.dart';
import 'package:phu_tho_mobile/domain/models/response/account/account_response.dart';

class LoginState extends Equatable {
  final LoadStatus loadStatus;
  final LoginRequest loginRequest;
  final String message;

  const LoginState({
    this.loadStatus = LoadStatus.initial,
    this.loginRequest = const LoginRequest(),
    this.message = '',
  });

  LoginState copyWith({
    LoadStatus? loadStatus,
    LoginRequest? loginRequest,
    String? message,
  }) {
    return LoginState(
      loadStatus: loadStatus ?? this.loadStatus,
      loginRequest: loginRequest ?? this.loginRequest,
      message: message ?? this.message,
    );
  }

  @override
  List<Object?> get props => [loadStatus, loginRequest, message];
}
