import 'package:phu_tho_mobile/application/enums/type_action.dart';

class ListJobArgument {
  final TypeAction typeAction;
  final int? idBusiness;

  const ListJobArgument({required this.typeAction, this.idBusiness});
}
