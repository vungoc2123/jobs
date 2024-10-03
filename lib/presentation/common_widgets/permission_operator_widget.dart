import 'package:flutter/material.dart';
import 'package:phu_tho_mobile/application/enums/permission_operator.dart';
import 'package:phu_tho_mobile/data/data_sources/storage/shared_preferences/shared_preferences_helper.dart';
import 'package:phu_tho_mobile/di.dart';

class PermissionOperatorWidget extends StatefulWidget {
  final PermissionOperator operator;
  final Widget child;

  const PermissionOperatorWidget({super.key, required this.operator, required this.child});

  @override
  State<PermissionOperatorWidget> createState() => _PermissionOperatorWidgetState();
}

class _PermissionOperatorWidgetState extends State<PermissionOperatorWidget> {
  List<PermissionOperator> operators = [];

  @override
  void initState() {
    super.initState();
    init();
  }

  void init() async {
    final loggedInfo = await getIt.get<SharedPreferencesHelper>().getLoggedInfo();
    setState(() {
      operators = loggedInfo?.operators ?? [];
    });
  }

  @override
  Widget build(BuildContext context) {
    if (operators.contains(widget.operator)) return widget.child;

    return const SizedBox();
  }
}
