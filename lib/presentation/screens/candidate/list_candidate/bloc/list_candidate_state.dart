import 'package:equatable/equatable.dart';
import 'package:phu_tho_mobile/domain/models/response/profile.dart';

class ListCandidateState extends Equatable {
  final List<ProfileModel> profiles;

  const ListCandidateState({this.profiles = const []});

  ListCandidateState copyWith({List<ProfileModel>? profiles}){
    return ListCandidateState(profiles: profiles ?? this.profiles);
  }

  @override
  List<Object?> get props => [profiles];
}
