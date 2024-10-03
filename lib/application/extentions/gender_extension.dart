import '../enums/gender.dart';

extension GenderExtension on Gender {
  int get getValue {
    switch (this) {
      case Gender.men:
        return 1;
      case Gender.woman:
        return 2;
      default:
        return 0;
    }
  }

  String get getName {
    switch (this) {
      case Gender.men:
        return "Nam";
      case Gender.woman:
        return "Nữ";
      default:
        return "Chưa có";
    }
  }
}
