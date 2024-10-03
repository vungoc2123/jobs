part of 'account_cubit.dart';

class AccountState extends Equatable {
  final UserProfileResponse? userProfile;
  final LoadStatus getProfileLoadStatus;
  final LoadStatus getUrlReportStatus;
  final LoadStatus loadActionOfUser;
  final List<GroupMenuModel> groupMenus;
  final String urlReport;

  const AccountState(
      {this.userProfile,
      this.getProfileLoadStatus = LoadStatus.initial,
      this.loadActionOfUser = LoadStatus.initial,
      this.groupMenus = const [],
      this.getUrlReportStatus = LoadStatus.initial,
      this.urlReport = ''});

  AccountState copyWith(
      {UserProfileResponse? userProfile,
      LoadStatus? getProfileLoadStatus,
      LoadStatus? getUrlReportStatus,
      String? urlReport,
      LoadStatus? loadActionOfUser,
      List<GroupMenuModel>? groupMenus}) {
    return AccountState(
        userProfile: userProfile ?? this.userProfile,
        getProfileLoadStatus: getProfileLoadStatus ?? this.getProfileLoadStatus,
        loadActionOfUser: loadActionOfUser ?? this.loadActionOfUser,
        groupMenus: groupMenus ?? this.groupMenus,
        getUrlReportStatus: getUrlReportStatus ?? this.getUrlReportStatus,
        urlReport: urlReport ?? this.urlReport);
  }

  @override
  List<Object?> get props => [
        userProfile,
        getProfileLoadStatus,
        loadActionOfUser,
        groupMenus,
        urlReport,
        getUrlReportStatus
      ];
}
