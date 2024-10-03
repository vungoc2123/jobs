import 'package:intl/intl.dart';

extension IntExtension on int{
  String formatCurrency() {
    final NumberFormat numberFormat = NumberFormat('#,###', 'vi_VN');
    String formattedNumber = numberFormat.format(this);
    return '$formattedNumber VND';
  }

}