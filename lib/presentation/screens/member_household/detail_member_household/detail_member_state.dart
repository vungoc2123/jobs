import 'package:equatable/equatable.dart';
import 'package:phu_tho_mobile/application/enums/load_status.dart';
import 'package:phu_tho_mobile/domain/models/response/member_household/member_household_response.dart';

class DetailMemberState extends Equatable {
  final LoadStatus loadStatus;
  final MemberHouseholdResponse member;

  const DetailMemberState(
      {this.loadStatus = LoadStatus.initial,
      this.member = const MemberHouseholdResponse()});

  DetailMemberState copyWith(
      {LoadStatus? loadStatus, MemberHouseholdResponse? member}) {
    return DetailMemberState(
        loadStatus: loadStatus ?? this.loadStatus,
        member: member ?? this.member);
  }

  @override
  List<Object?> get props => [member, loadStatus];
}
