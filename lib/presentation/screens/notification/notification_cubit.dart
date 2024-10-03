import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:phu_tho_mobile/application/enums/load_status.dart';
import 'package:phu_tho_mobile/data/data_sources/storage/shared_preferences/shared_preferences_helper.dart';
import 'package:phu_tho_mobile/di.dart';
import 'package:phu_tho_mobile/domain/models/request/notification/notification_request.dart';
import 'package:phu_tho_mobile/domain/repositories/notification_repository.dart';
import 'package:phu_tho_mobile/presentation/screens/notification/notification_state.dart';

class NotificationCubit extends Cubit<NotificationState> {
  NotificationCubit() : super(const NotificationState());

  final _repo = getIt.get<NotificationRepository>();

  Future<void> getNotifications() async {
    try {
      emit(state.copyWith(loadStatus: LoadStatus.loading));
      final response = await _repo.getAllNotification(state.request);
      if (response.isRight) {
        emit(state.copyWith(
            loadStatus: LoadStatus.success,
            notifications: response.right.listItem,
            hasNextPage: response.right.hasNextPage));
        return;
      }
      emit(state.copyWith(loadStatus: LoadStatus.failure));
    } catch (e) {
      emit(state.copyWith(loadStatus: LoadStatus.failure));
    }
  }

  Future<void> getMoreNotifications() async {
    try {
      if (!state.hasNextPage || state.loadMoreStatus == LoadStatus.loading) {
        return;
      }

      emit(state.copyWith(loadMoreStatus: LoadStatus.loading));
      onChangeRequest(
          state.request.copyWith(pageIndex: state.request.pageIndex + 1));
      final response = await _repo.getAllNotification(state.request);
      if (response.isRight) {
        emit(state.copyWith(
            loadMoreStatus: LoadStatus.success,
            notifications: [...state.notifications, ...response.right.listItem],
            hasNextPage: response.right.hasNextPage));
        return;
      }
      emit(state.copyWith(loadMoreStatus: LoadStatus.failure));
    } catch (e) {
      emit(state.copyWith(loadMoreStatus: LoadStatus.failure));
    }
  }

  void onChangeRequest(NotificationRequest newRequest) {
    emit(state.copyWith(request: newRequest));
  }

  Future<void> getDetailNotification(
      int idNotification, bool loadTickRead) async {
    try {
      emit(state.copyWith(
          loadDetailNotification: LoadStatus.loading,
          loadTickRead: loadTickRead));
      final response = await _repo.getDetailNotification(idNotification);
      if (response.isRight) {
        emit(state.copyWith(
            loadDetailNotification: LoadStatus.success, not: response.right));
        return;
      }
      emit(state.copyWith(loadDetailNotification: LoadStatus.failure));
    } catch (e) {
      emit(state.copyWith(loadDetailNotification: LoadStatus.failure));
    }
  }

  Future<void> getNotificationUnRead() async {
    try {
      final loggedInfo = await getIt<SharedPreferencesHelper>().getLoggedInfo();
      if (loggedInfo?.accessToken != '') {
        emit(state.copyWith(loadNotificationUnRead: LoadStatus.loading));
        final response = await _repo.getAllUnReadNotification();
        if (response.isRight) {
          emit(state.copyWith(
              loadNotificationUnRead: LoadStatus.success,
              notificationsUnRead: response.right));
          return;
        }
        emit(state.copyWith(loadNotificationUnRead: LoadStatus.failure));
      }
    } catch (e) {
      emit(state.copyWith(loadNotificationUnRead: LoadStatus.failure));
    }
  }
}
