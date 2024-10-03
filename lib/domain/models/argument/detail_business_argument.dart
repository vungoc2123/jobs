import 'package:phu_tho_mobile/application/enums/type_action.dart';

class DetailBusinessArgument {
  final int idBusiness;
  final TypeAction type;

  const DetailBusinessArgument(
      {this.idBusiness = -1, this.type = TypeAction.extract});
}
