import 'dart:async';

import 'package:form/src/domain/params/login_params.dart';
import 'package:form/src/domain/usecases/login/login_usecase.dart';

class FormController {
  final LoginUsecase loginUsecase;

  String email = '';
  String password = '';
  String? emailError;
  String? passwordError;

  FormController(this.loginUsecase);

  void onChangedEmail(String value) {
    if (value.isEmpty) {
      emailError = 'Digite um e-mail';
    } else {
      email = value;
      emailError = null;
    }
  }

  void onChangedPassword(String value) {
    if (value.isEmpty) {
      passwordError = 'Digite uma senha';
    } else {
      password = value;
      passwordError = null;
    }
  }

  Future<bool> login() async {
    final canLogin = emailError == null && passwordError == null && email.isNotEmpty && password.isNotEmpty;
    if (!canLogin) return false;
    final result = await loginUsecase(LoginParams(email, password));
    return result.fold<bool>((left) => false, (right) => true);
  }
}
