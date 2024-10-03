import 'package:equatable/equatable.dart';
import 'package:phu_tho_mobile/application/enums/load_status.dart';

class SplashSate extends Equatable{
  final LoadStatus loadStatus;

  const SplashSate({this.loadStatus=LoadStatus.initial});

  SplashSate copyWith({LoadStatus? loadStatus}){
    return SplashSate(loadStatus:loadStatus ?? this.loadStatus);
  }

  @override
  List<Object?> get props => [loadStatus];

}