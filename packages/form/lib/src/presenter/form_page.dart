import 'dart:math';

import 'package:core/core.dart';
import 'package:dependencies/dependencies.dart';
import 'package:flutter/material.dart';
import 'package:form/src/presenter/form_controller.dart';

class FormPage extends StatefulWidget {
  const FormPage({super.key});

  @override
  State<FormPage> createState() => _FormPageState();
}

class _FormPageState extends State<FormPage> {
  late FormController controller;
  var isLoading = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    controller = DependencyInjectionWidget.of(context)!.get();
  }

  void showIsLoggedSnackBar() {
    controller.analyticsService.logEvent(AnalyticsEventType.logged, {});
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
              Observer(
                builder: (context) => TextField(
                  decoration: InputDecoration(
                    border: const OutlineInputBorder(),
                    hintText: 'Ex.: email@provedor.com',
                    label: const Text('E-mail'),
                    errorText: controller.formStore.emailError,
                    //suffix: Icon(Icons.hide_source),
                  ),
                  onChanged: (value) => controller.formStore.changeEmail(value),
                ),
              ),
              const SizedBox(height: 20),
              Observer(
                builder: (context) => TextField(
                  decoration: InputDecoration(
                    border: const OutlineInputBorder(),
                    hintText: 'Ex.: suasenha123',
                    label: const Text('Senha'),
                    errorText: controller.formStore.passwordError,
                    //suffix: Icon(Icons.hide_source),
                  ),
                  onChanged: (value) => controller.formStore.changePassword(value),
                ),
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
                            final isLogged = await controller.login();
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
