import 'dart:async';

import 'package:core/core.dart';
import 'package:form/src/domain/params/login_params.dart';
import 'package:form/src/domain/usecases/login/login_usecase.dart';

import 'stores/form_store.dart';

class FormController {
  final LoginUsecase loginUsecase;
  final FormStore formStore;
  final AnalyticsService analyticsService;

  FormController(this.loginUsecase, this.analyticsService, this.formStore);

  Future<bool> login() async {
    final canLogin = formStore.isValid;
    if (!canLogin) return false;
    final result = await loginUsecase(LoginParams(formStore.email, formStore.password));
    return result.fold<bool>((left) => false, (right) => true);
  }
}
