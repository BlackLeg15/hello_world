import 'dart:math';

import 'package:flutter/material.dart';
import 'package:form/src/domain/usecases/login/login_usecase_impl.dart';
import 'package:form/src/external/datasources/mock/login_datasource_mock_impl.dart';
import 'package:form/src/infra/repositories/login_repository_impl.dart';
import 'package:form/src/presenter/form_controller.dart';

import '../domain/repositories/login_repository.dart';
import '../domain/usecases/login/login_usecase.dart';
import '../infra/datasources/login_datasource.dart';

class FormPage extends StatefulWidget {
  const FormPage({super.key});

  @override
  State<FormPage> createState() => _FormPageState();
}

class _FormPageState extends State<FormPage> {
  late FormController formController;
  late LoginUsecase loginUsecase;
  late LoginRepository loginRepository;
  late LoginDatasource loginDatasource;
  var isLoading = false;

  @override
  void initState() {
    super.initState();
    loginDatasource = LoginDatasourceMockImpl();
    loginRepository = LoginRepositoryImpl(loginDatasource);
    loginUsecase = LoginUsecaseImpl(loginRepository);
    formController = FormController(loginUsecase);
  }

  void showIsLoggedSnackBar() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Logado com sucesso + Clean Dart'),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Form Page'),
      ),
      body: Center(
        child: Container(
          alignment: Alignment.center,
          constraints: const BoxConstraints(maxWidth: 500),
          margin: const EdgeInsets.symmetric(horizontal: 50),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              StatefulBuilder(
                builder: (context, setState) {
                  return TextField(
                    decoration: InputDecoration(
                      border: const OutlineInputBorder(),
                      hintText: 'Ex.: email@provedor.com',
                      label: const Text('E-mail'),
                      errorText: formController.emailError,
                      //suffix: Icon(Icons.hide_source),
                    ),
                    onChanged: (value) => setState(() => formController.onChangedEmail(value)),
                  );
                },
              ),
              const SizedBox(height: 20),
              StatefulBuilder(
                builder: (context, setState) {
                  return TextField(
                    decoration: InputDecoration(
                      border: const OutlineInputBorder(),
                      hintText: 'Ex.: suasenha123',
                      label: const Text('Senha'),
                      errorText: formController.passwordError,
                      //suffix: Icon(Icons.hide_source),
                    ),
                    onChanged: (value) => setState(() => formController.onChangedPassword(value)),
                  );
                },
              ),
              const SizedBox(height: 20),
              StatefulBuilder(
                builder: (context, setState) {
                  return isLoading
                      ? const CircularProgressIndicator()
                      : ElevatedButton(
                          style: ButtonStyle(
                              minimumSize: MaterialStateProperty.all(Size(max(size.width * 0.1, 120), max(size.width * 0.01, 60)))),
                          onPressed: () async {
                            setState(() {
                              isLoading = true;
                            });
                            final isLogged = await formController.login();
                            setState(() {
                              isLoading = false;
                            });
                            if (isLogged) {
                              showIsLoggedSnackBar();
                            }
                          },
                          child: const Text('Login'),
                        );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
