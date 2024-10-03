import 'package:bloc/bloc.dart';
import 'package:phu_tho_mobile/application/enums/permission_operator.dart';
import 'package:phu_tho_mobile/presentation/screens/discover/discover_state.dart';

import '../../../data/data_sources/storage/shared_preferences/shared_preferences_helper.dart';
import '../../../di.dart';

class DiscoverCubit extends Cubit<DiscoverState> {
  DiscoverCubit() : super(const DiscoverState());

  final SharedPreferencesHelper _sharedPreference =
      getIt.get<SharedPreferencesHelper>();

  final List<PermissionOperator> permission = [
    PermissionOperator.getConsultingActivities,
    PermissionOperator.getJobIntroductionActivities,
    PermissionOperator.getLaborSupplyActivities,
    PermissionOperator.getJobEmptyInfoCollectionActivities,
    PermissionOperator.getJobSeekerInfoCollectionActivities,
    PermissionOperator.getEmploymentStatusOfEmployee,
    PermissionOperator.getEmploymentStatusOfEmployee,
  ];

  Future<void> checkPermission() async {
    try {
      // final loggedInfo = await _sharedPreference.getLoggedInfo();
      // emit(state.copyWith(operators: loggedInfo?.operators ?? []));
      // if (state.operators.isEmpty) {
      //   emit(state.copyWith(noPermission: true));
      //   return;
      // }
      //
      // for(PermissionOperator e in permission) {
      //   if (state.operators.any((x) => x == e)) {
      //     emit(state.copyWith(noPermission: false));
      //     return;
      //   }
      // }

      emit(state.copyWith(noPermission: false));
    } catch (e) {
      emit(state.copyWith(noPermission: false));
      return;
    }
  }

  bool checkPermissionFoFuture(PermissionOperator permissionOperator) {
    // return state.operators.contains(permissionOperator);
    return true;
  }
}
