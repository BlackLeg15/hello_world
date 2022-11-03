import 'dart:math';

import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:form/src/presenter/form_controller.dart';

class FormPage extends StatefulWidget {
  const FormPage({super.key});

  @override
  State<FormPage> createState() => _FormPageState();
}

class _FormPageState extends State<FormPage> {
  FormController? controller;
  var isLoading = false;

  var formStoreLoading = false;

  var listenersHaveBeenAdded = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    controller ??= DependencyInjectionWidget.of(context)!.get();
    if (!listenersHaveBeenAdded) {
      addListeners();
    }
  }

  void addListeners() {
    final store = controller!.formStore;
    store.addListener(whenIsLoading);
    listenersHaveBeenAdded = true;
  }

  void removeListeners() {
    final store = controller!.formStore;
    store.removeListener(whenIsLoading);
  }

  void whenIsLoading() {
    if (controller!.formStore.isLoading && controller!.formStore.isLoading != formStoreLoading) {
      formStoreLoading = controller!.formStore.isLoading;
      debugPrint(controller!.formStore.isLoading.toString());
    }
  }

  void showIsLoggedSnackBar() {
    controller!.analyticsService.logEvent(AnalyticsEventType.logged, {});
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Logado com sucesso + Clean Dart'),
      ),
    );
  }

  @override
  void dispose() {
    if (listenersHaveBeenAdded) {
      removeListeners();
    }
    controller!.formStore.dispose();
    super.dispose();
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
              AnimatedBuilder(
                animation: controller!.formStore,
                builder: (context, child) => TextField(
                  decoration: InputDecoration(
                    border: const OutlineInputBorder(),
                    hintText: 'Ex.: email@provedor.com',
                    label: const Text('E-mail'),
                    errorText: controller!.formStore.emailError,
                    //suffix: Icon(Icons.hide_source),
                  ),
                  onChanged: (value) => controller!.formStore.changeEmail(value),
                ),
              ),
              const SizedBox(height: 20),
              AnimatedBuilder(
                animation: controller!.formStore,
                builder: (context, child) => TextField(
                  decoration: InputDecoration(
                    border: const OutlineInputBorder(),
                    hintText: 'Ex.: suasenha123',
                    label: const Text('Senha'),
                    errorText: controller!.formStore.passwordError,
                    //suffix: Icon(Icons.hide_source),
                  ),
                  onChanged: (value) => controller!.formStore.changePassword(value),
                ),
              ),
              const SizedBox(height: 20),
              AnimatedBuilder(
                animation: controller!.formStore,
                builder: (context, child) {
                  final isValid = controller!.formStore.isValid;
                  final isLoading = controller!.formStore.isLoading;
                  return isLoading
                      ? const CircularProgressIndicator()
                      : ElevatedButton(
                          style: ButtonStyle(
                            minimumSize: MaterialStateProperty.all(Size(max(size.width * 0.1, 120), max(size.width * 0.01, 60))),
                            backgroundColor: MaterialStateProperty.resolveWith((states) {
                              if (states.contains(MaterialState.disabled)) {
                                return Colors.blueGrey;
                              } else {
                                return Theme.of(context).primaryColor;
                              }
                            }),
                          ),
                          onPressed: !isValid
                              ? null
                              : () async {
                                  final isLogged = await controller!.login();
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
