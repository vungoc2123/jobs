import 'package:phu_tho_mobile/application/enums/permission_operator.dart';
import 'package:phu_tho_mobile/gen/assets.gen.dart';

class GroupMenuModel {
  final String title;
  final List<MenuModel> children;

  const GroupMenuModel({required this.title, required this.children});
}

class MenuModel {
  final PermissionOperator? operator;
  final SvgGenImage icon;
  final String title;
  final Function? onTap;

  const MenuModel({this.operator, required this.icon, required this.title, this.onTap});
}
