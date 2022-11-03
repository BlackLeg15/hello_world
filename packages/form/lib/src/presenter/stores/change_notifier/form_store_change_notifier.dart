import 'package:flutter/foundation.dart';

class FormStoreChangeNotifier extends ChangeNotifier {
  String email = '';
  String password = '';

  String? emailError;
  String? passwordError;

  void changeEmail(String value) {
    email = value;
    emailError = value.isEmpty ? 'Digite um e-mail' : null;
    notifyListeners();
  }

  void changePassword(String value) {
    password = value;
    passwordError = value.isEmpty ? 'Digite uma senha' : null;
    notifyListeners();
  }

  bool isLoading = false;

  void changeLoading(bool value) {
    isLoading = value;
    notifyListeners();
  }

  bool get isValid => emailError == null && passwordError == null && email.isNotEmpty && password.isNotEmpty;
}
