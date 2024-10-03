import 'package:equatable/equatable.dart';
import 'package:phu_tho_mobile/application/enums/load_status.dart';
import 'package:phu_tho_mobile/domain/models/request/notification/notification_request.dart';
import 'package:phu_tho_mobile/domain/models/response/notification/notification_response.dart';

class NotificationState extends Equatable {
  final LoadStatus loadStatus;
  final LoadStatus loadMoreStatus;
  final LoadStatus loadDetailNotification;
  final LoadStatus loadNotificationUnRead;
  final bool loadTickRead;
  final List<NotificationResponse> notifications;
  final List<NotificationResponse> notificationsUnRead;
  final NotificationResponse not;
  final NotificationRequest request;
  final bool hasNextPage;

  const NotificationState(
      {this.loadStatus = LoadStatus.initial,
      this.loadMoreStatus = LoadStatus.initial,
      this.loadNotificationUnRead = LoadStatus.initial,
      this.loadDetailNotification = LoadStatus.initial,
      this.loadTickRead = false,
      this.request = const NotificationRequest(),
      this.not = const NotificationResponse(),
      this.notifications = const [],
      this.notificationsUnRead = const [],
      this.hasNextPage = true});

  NotificationState copyWith(
      {LoadStatus? loadStatus,
      LoadStatus? loadMoreStatus,
      LoadStatus? loadDetailNotification,
      LoadStatus? loadNotificationUnRead,
      bool? loadTickRead,
      NotificationResponse? not,
      List<NotificationResponse>? notifications,
      List<NotificationResponse>? notificationsUnRead,
      NotificationRequest? request,
      bool? hasNextPage}) {
    return NotificationState(
        loadStatus: loadStatus ?? this.loadStatus,
        request: request ?? this.request,
        loadDetailNotification:
            loadDetailNotification ?? this.loadDetailNotification,
        not: not ?? this.not,
        loadMoreStatus: loadMoreStatus ?? this.loadMoreStatus,
        notifications: notifications ?? this.notifications,
        hasNextPage: hasNextPage ?? this.hasNextPage,
        loadNotificationUnRead:
            loadNotificationUnRead ?? this.loadNotificationUnRead,
        notificationsUnRead: notificationsUnRead ?? this.notificationsUnRead,
        loadTickRead: loadTickRead ?? this.loadTickRead);
  }

  @override
  List<Object?> get props => [
        loadStatus,
        loadMoreStatus,
        notifications,
        request,
        loadDetailNotification,
        not,
        loadNotificationUnRead,
        notificationsUnRead,
        loadTickRead
      ];
}
