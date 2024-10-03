import 'package:intl/intl.dart';

extension DateTimeExtension on DateTime{
  String formatToDMY(){
    return DateFormat('dd/MM/yyyy').format(this);
  }
  String formatToHSDMY(){
    return DateFormat('HH:ss dd/MM/yyyy').format(this);
  }
  String formatToHS(){
    return DateFormat('HH:ss').format(this);
  }

  String formatToY(){
    return DateFormat('yyyy').format(this);
  }
}