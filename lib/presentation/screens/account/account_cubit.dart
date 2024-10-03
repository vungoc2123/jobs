import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:phu_tho_mobile/application/constants/app_deep_link.dart';
import 'package:phu_tho_mobile/application/dto/menu_model.dart';
import 'package:phu_tho_mobile/application/enums/load_status.dart';
import 'package:phu_tho_mobile/application/enums/permission_operator.dart';
import 'package:phu_tho_mobile/application/extentions/string_extension.dart';
import 'package:phu_tho_mobile/data/data_sources/storage/shared_preferences/shared_preferences_helper.dart';
import 'package:phu_tho_mobile/di.dart';
import 'package:phu_tho_mobile/domain/models/response/user/user_profile_response.dart';
import 'package:phu_tho_mobile/domain/repositories/user_repository.dart';

part 'account_state.dart';

class AccountCubit extends Cubit<AccountState> {
  AccountCubit() : super(const AccountState());

  final _userRepository = getIt.get<UserRepository>();
  final _sharedPreference = getIt.get<SharedPreferencesHelper>();

  Future<void> getUserProfile() async {
    try {
      emit(state.copyWith(getProfileLoadStatus: LoadStatus.loading));
      final loggedInfo = await _sharedPreference.getLoggedInfo();
      if (loggedInfo != null) {
        final response =
            await _userRepository.getUserProfile(loggedInfo.accountId);

        if (response.isRight) {
          emit(state.copyWith(
            getProfileLoadStatus: LoadStatus.success,
            userProfile: response.right.data,
          ));
          return;
        }
      }
      emit(state.copyWith(getProfileLoadStatus: LoadStatus.failure));
    } catch (e) {
      emit(state.copyWith(getProfileLoadStatus: LoadStatus.failure));
    }
  }

  Future<void> logout() async {
    _sharedPreference.removeLoggedInfo();
  }

  Future<void> filterActionOfUser(List<GroupMenuModel> groupMenus) async {
    try {
      final loggedInfo = await _sharedPreference.getLoggedInfo();
      List<PermissionOperator> operators = loggedInfo?.operators ?? [];
      emit(state.copyWith(loadActionOfUser: LoadStatus.loading));
      final response = groupMenus.map((group) {
        List<MenuModel> filteredMenus = group.children.where((menu) {
          // Nếu operator là null, cho phép luôn
          if (menu.operator == null) {
            return true;
          }
          // Kiểm tra operator của menu có trong allowedOperators không
          return operators.contains(menu.operator);
        }).toList();
        return GroupMenuModel(title: group.title, children: filteredMenus);
      }).toList();
      emit(state.copyWith(
          loadActionOfUser: LoadStatus.success,
          groupMenus: response
              .where((element) => element.children.isNotEmpty)
              .toList()));
    } catch (e) {
      emit(state.copyWith(loadActionOfUser: LoadStatus.failure));
    }
  }

  Future<void> getUrlReport() async {
    try {
      emit(state.copyWith(getUrlReportStatus: LoadStatus.loading));
      final urlWithToken =
          await AppDeepLink.report.toResourceUrl().withUserToken();
      final urlWithParam = urlWithToken.withParam({"IdModule": 7});
      emit(state.copyWith(
          getUrlReportStatus: LoadStatus.success, urlReport: urlWithParam));
    } catch (e) {
      emit(state.copyWith(getUrlReportStatus: LoadStatus.failure));
    }
  }
}
