import 'dart:async';

import 'package:core/core.dart';
import 'package:form/src/domain/params/login_params.dart';
import 'package:form/src/domain/usecases/login/login_usecase.dart';
import 'package:form/src/presenter/stores/change_notifier/form_store_change_notifier.dart';


class FormController {
  final LoginUsecase loginUsecase;
  //final FormStore formStore;
  final AnalyticsService analyticsService;
  final FormStoreChangeNotifier formStore;

  FormController(this.loginUsecase, this.analyticsService, this.formStore);

  Future<bool> login() async {
    final canLogin = formStore.isValid;
    if (!canLogin) return false;
    formStore.changeLoading(true);
    final result = await loginUsecase(LoginParams(formStore.email, formStore.password));
    formStore.changeLoading(false);
    return result.fold<bool>((left) => false, (right) => true);
  }

  @override
  int get hashCode => 999;

  @override
  bool operator ==(Object other) {
    return (other is FormController);
  }
}
