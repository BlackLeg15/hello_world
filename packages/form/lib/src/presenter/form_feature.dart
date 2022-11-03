import 'package:core/core.dart';
import 'package:flutter/widgets.dart';

import '../domain/usecases/login/login_usecase_impl.dart';
import '../external/datasources/mock/login_datasource_mock_impl.dart';
import '../infra/repositories/login_repository_impl.dart';
import 'form_controller.dart';
import 'form_page.dart';
import 'stores/change_notifier/form_store_change_notifier.dart';

class FormFeature extends Feature {
  const FormFeature({super.key});

  @override
  Widget get child => const FormPage();

  @override
  Map<Type, Object> dependencies({DependencyInjectionWidget? injector}) {
    final analyticsService = injector?.get<AnalyticsService>();
    if (analyticsService == null) {
      throw Exception();
    }
    final loginDatasource = LoginDatasourceMockImpl();
    final loginRepository = LoginRepositoryImpl(loginDatasource);
    final loginUsecase = LoginUsecaseImpl(loginRepository);
    //final formStore = FormStore();
    final formStore = FormStoreChangeNotifier();
    final formController = FormController(loginUsecase, analyticsService, formStore);
    return <Type, Object>{
      FormController: formController,
    };
  }
}
