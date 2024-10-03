import 'package:either_dart/either.dart';
import 'package:phu_tho_mobile/data/data_sources/api/api_response.dart';
import 'package:phu_tho_mobile/domain/models/request/notification/notification_request.dart';
import 'package:phu_tho_mobile/domain/models/response/notification/notification_response.dart';

abstract class NotificationRepository {
  Future<Either<String, ListDataResponse<NotificationResponse>>>
      getAllNotification(NotificationRequest request);

  Future<Either<String, List<NotificationResponse>>> getAllUnReadNotification();

  Future<Either<String, NotificationResponse>> getDetailNotification(
      int idNotification);
}
