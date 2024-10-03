import 'package:equatable/equatable.dart';
import 'package:phu_tho_mobile/application/enums/load_status.dart';
import 'package:phu_tho_mobile/domain/models/response/user/user_profile_response.dart';

class InformationAccountState extends Equatable {
  final LoadStatus loadStatus;
  final LoadStatus deleteStatus;
  final String message;
  final UserProfileResponse userProfile;

  const InformationAccountState(
      {this.loadStatus = LoadStatus.initial,
      this.deleteStatus = LoadStatus.initial,
      this.message = '',
      this.userProfile = const UserProfileResponse()});

  InformationAccountState copyWith(
      {LoadStatus? loadStatus,
      UserProfileResponse? userProfile,
      LoadStatus? deleteStatus,
      String? message}) {
    return InformationAccountState(
        message: message ?? this.message,
        deleteStatus: deleteStatus ?? this.deleteStatus,
        loadStatus: loadStatus ?? this.loadStatus,
        userProfile: userProfile ?? this.userProfile);
  }

  @override
  List<Object?> get props => [loadStatus, userProfile, deleteStatus, message];
}
