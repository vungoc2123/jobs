import 'package:either_dart/either.dart';
import 'package:phu_tho_mobile/data/data_sources/api/api_client.dart';
import 'package:phu_tho_mobile/data/data_sources/api/api_response.dart';
import 'package:phu_tho_mobile/di.dart';
import 'package:phu_tho_mobile/domain/models/request/notification/notification_request.dart';
import 'package:phu_tho_mobile/domain/models/response/notification/notification_response.dart';
import 'package:phu_tho_mobile/domain/repositories/notification_repository.dart';

class NotificationRepositoryImpl extends NotificationRepository {
  final _api = getIt.get<ApiClient>();

  @override
  Future<Either<String, ListDataResponse<NotificationResponse>>>
      getAllNotification(NotificationRequest request) async {
    try {
      final response = await _api.getAllNotification(request);
      if (response.status && response.data != null) {
        return Right(response.data!);
      }
      return Left(response.message);
    } catch (e) {
      return Left(e.toString());
    }
  }

  @override
  Future<Either<String, List<NotificationResponse>>>
      getAllUnReadNotification() async {
    try {
      final response = await _api.getUnReadNotification();
      if (response.status && response != null) {
        return Right(response.data!);
      }
      return Left(response.message);
    } catch (e) {
      return Left(e.toString());
    }
  }

  @override
  Future<Either<String, NotificationResponse>> getDetailNotification(
      int idNotification) async {
    try {
      final response = await _api.getDetailNotification(idNotification);
      if (response.status && response != null) {
        return Right(response.data!);
      }
      return Left(response.message);
    } catch (e) {
      return Left(e.toString());
    }
  }
}
