import 'package:equatable/equatable.dart';
import 'package:phu_tho_mobile/application/enums/gender.dart';
import 'package:phu_tho_mobile/application/enums/load_status.dart';
import 'package:phu_tho_mobile/domain/models/request/register_request/register_request.dart';

import '../../../domain/models/response/filter_response/filter_response.dart';

class RegisterState extends Equatable {
  final LoadStatus status;
  final String message;
  final RegisterRequest request;
  final String error;

  final String errorFullName;
  final String errorUserName;
  final String errorPassword;
  final String errorConfirmPass;
  final String errorPhoneNumber;
  final String errorEmail;
  final String errorAddress;

  final String fullName;
  final String userName;
  final String password;
  final String confirmPass;
  final String phoneNumber;
  final String email;
  final String address;
  final Gender gender;
  final String type;
  final List<FilterResponse> typeAccount;

  const RegisterState(
      {this.request = const RegisterRequest(),
      this.status = LoadStatus.initial,
      this.errorPassword = '',
      this.errorUserName = '',
      this.errorAddress = '',
      this.errorConfirmPass = '',
      this.errorEmail = '',
      this.errorFullName = '',
      this.errorPhoneNumber = '',
      this.message = '',
      this.error = '',
      this.address = '',
      this.email = '',
      this.phoneNumber = '',
      this.confirmPass = '',
      this.password = '',
      this.fullName = '',
      this.gender = Gender.men,
      this.typeAccount = const [],
      this.type = 'NGUOIDUNG',
      this.userName = ''});

  RegisterState copyWith(
      {RegisterRequest? request,
      LoadStatus? status,
      String? errorPassword,
      String? errorUserName,
      String? errorAddress,
      String? errorConfirmPass,
      String? errorEmail,
      String? errorFullName,
      String? errorPhoneNumber,
      String? message,
      String? error,
      String? address,
      String? email,
      String? phoneNumber,
      String? confirmPass,
      String? password,
      String? fullName,
      String? userName,
      String? type,
      List<FilterResponse>? typeAccount,
      Gender? gender}) {
    return RegisterState(
        request: request ?? this.request,
        status: status ?? this.status,
        errorPassword: errorPassword ?? this.errorPassword,
        errorUserName: errorUserName ?? this.errorUserName,
        errorAddress: errorAddress ?? this.errorAddress,
        errorConfirmPass: errorConfirmPass ?? this.errorConfirmPass,
        errorEmail: errorEmail ?? this.errorEmail,
        errorFullName: errorFullName ?? this.errorFullName,
        errorPhoneNumber: errorPhoneNumber ?? this.errorPhoneNumber,
        message: message ?? this.message,
        error: error ?? this.error,
        address: address ?? this.address,
        email: email ?? this.email,
        phoneNumber: phoneNumber ?? this.phoneNumber,
        confirmPass: confirmPass ?? this.confirmPass,
        password: password ?? this.password,
        fullName: fullName ?? this.fullName,
        userName: userName ?? this.userName,
        gender: gender ?? this.gender,
        type: type ?? this.type,
        typeAccount: typeAccount ?? this.typeAccount);
  }

  @override
  // TODO: implement props
  List<Object?> get props => [
        status,
        message,
        request,
        error,
        errorPhoneNumber,
        errorFullName,
        errorEmail,
        errorConfirmPass,
        errorAddress,
        errorUserName,
        errorPassword,
        email,
        password,
        confirmPass,
        userName,
        fullName,
        address,
        phoneNumber,
        gender,
        typeAccount,
        type
      ];
}
