import 'package:equatable/equatable.dart';

import '../../../application/enums/permission_operator.dart';

class DiscoverState extends Equatable{
  final List<PermissionOperator> operators;
  final bool noPermission;
  const DiscoverState({this.operators = const [], this.noPermission = true});

  DiscoverState copyWith({List<PermissionOperator>? operators, bool? noPermission}){
    return DiscoverState(operators: operators ?? this.operators, noPermission: noPermission ?? this.noPermission);
  }

  @override
  // TODO: implement props
  List<Object?> get props => [operators, noPermission];
}