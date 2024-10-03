class AppValidator {
  static bool validatePhoneNumber(String phone) {
    return RegExp(r'^0[0-9]{9}$').hasMatch(phone);
  }

  static bool validateEmail(String email) {
    return RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$')
        .hasMatch(email);
  }
}
