import 'package:bloc/bloc.dart';
import 'package:phu_tho_mobile/application/enums/gender.dart';
import 'package:phu_tho_mobile/application/enums/load_status.dart';
import 'package:phu_tho_mobile/application/extentions/gender_extension.dart';
import 'package:phu_tho_mobile/application/utils/validator.dart';
import 'package:phu_tho_mobile/di.dart';
import 'package:phu_tho_mobile/domain/models/request/register_request/register_request.dart';
import 'package:phu_tho_mobile/domain/repositories/authentication_repository.dart';
import 'package:phu_tho_mobile/domain/repositories/dict_item_repository.dart';
import 'package:phu_tho_mobile/presentation/screens/register/register_state.dart';

class RegisterCubit extends Cubit<RegisterState> {
  RegisterCubit() : super(const RegisterState());

  final repo = getIt.get<AuthenticationRepository>();
  final dictItem = getIt.get<DictItemRepository>();

  Future<void> getDictItem() async {
    try {
      final response = await dictItem.getTypeAccount();
      if (response.isRight) {
        emit(state.copyWith(typeAccount: response.right));
        return;
      }
      emit(state.copyWith(error: response.left));
    } catch (e) {
      emit(state.copyWith(error: e.toString()));
    }
  }

  Future<void> createAccount() async {
    if (validation()) {
      try {
        final request = RegisterRequest(
            address: state.address,
            fullName: state.fullName,
            phoneNumber: state.phoneNumber,
            confirmPass: state.confirmPass,
            password: state.password,
            email: state.email,
            useName: state.userName,
            gender: state.gender.getValue);
        emit(state.copyWith(status: LoadStatus.loading, request: request));
        final response = await repo.registerAccount(state.request);
        if (response.isRight) {
          emit(state.copyWith(
              status: LoadStatus.success, message: response.right));
          return;
        }
        emit(
            state.copyWith(status: LoadStatus.failure, message: response.left));
      } catch (e) {
        emit(state.copyWith(status: LoadStatus.failure, message: e.toString()));
      }
      return;
    }
  }

  bool validateFullName() {
    if (state.fullName.isEmpty) {
      emit(state.copyWith(errorFullName: "Không được để trống"));
      return false;
    }
    emit(state.copyWith(errorFullName: ""));
    return true;
  }

  bool validateUseName() {
    if (state.userName.isEmpty) {
      emit(state.copyWith(errorUserName: "Không được để trống"));
      return false;
    }
    emit(state.copyWith(errorUserName: ""));
    return true;
  }

  bool validatePassword() {
    if (state.password.isEmpty) {
      emit(state.copyWith(errorPassword: "Không được để trống"));
      return false;
    }
    emit(state.copyWith(errorPassword: ""));
    return true;
  }

  bool validateConfirmPassword() {
    if (state.confirmPass.isEmpty) {
      emit(state.copyWith(errorConfirmPass: "Không được để trống"));
      return false;
    }
    if (state.confirmPass != state.password) {
      emit(state.copyWith(errorConfirmPass: "Mật khẩu không khớp"));

      return false;
    }
    emit(state.copyWith(errorConfirmPass: ""));
    return true;
  }

  bool validatePhoneNumber() {
    if (state.phoneNumber.isEmpty) {
      emit(state.copyWith(errorPhoneNumber: "Không được để trống"));
      return false;
    }
    if (!AppValidator.validatePhoneNumber(state.phoneNumber)) {
      emit(state.copyWith(
          errorPhoneNumber: "Không đúng định dạng số điện thoại"));
      return false;
    }
    emit(state.copyWith(errorPhoneNumber: ""));
    return true;
  }

  bool validateEmail() {
    if (state.email.isEmpty) {
      emit(state.copyWith(errorEmail: "Không được để trống"));
      return false;
    }

    if (!AppValidator.validateEmail(state.email)) {
      emit(state.copyWith(errorEmail: "Không đúng định dạng email"));
      return false;
    }
    emit(state.copyWith(errorEmail: ""));
    return true;
  }

  bool validateAddress() {
    if (state.address.isEmpty) {
      emit(state.copyWith(errorAddress: "Không được để trống"));
      return false;
    }
    emit(state.copyWith(errorAddress: ""));
    return true;
  }

  bool validation() {
    bool check = true;
    if (!validateFullName()) {
      check = false;
    }

    if (!validateUseName()) {
      check = false;
    }

    if (!validatePassword()) {
      check = false;
    }

    if (!validateConfirmPassword()) {
      check = false;
    }

    if (!validatePhoneNumber()) {
      check = false;
    }

    if (!validateEmail()) {
      check = false;
    }

    if (!validateAddress()) {
      check = false;
    }

    return check;
  }

  void changeRequest(
      {String? useName,
      String? email,
      String? password,
      String? confirmPass,
      String? phoneNumber,
      Gender? gender,
      String? fullName,
      String? address,
      String? type,
      DateTime? dateOfBirth}) {
    emit(state.copyWith(
        userName: useName,
        email: email,
        password: password,
        confirmPass: confirmPass,
        phoneNumber: phoneNumber,
        fullName: fullName,
        address: address,
        type: type,
        gender: gender));
  }
}
