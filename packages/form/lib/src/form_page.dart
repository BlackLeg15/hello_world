import 'dart:math';

import 'package:flutter/material.dart';

class FormPage extends StatefulWidget {
  const FormPage({super.key});

  @override
  State<FormPage> createState() => _FormPageState();
}

class _FormPageState extends State<FormPage> {
  String email = '';
  String password = '';
  String? emailError;
  String? passwordError;

  void onChangedEmail(String value) {
    if (value.isEmpty) {
      setState(() {
        emailError = 'Digite um e-mail';
      });
    } else {
      setState(() {
        email = value;
        emailError = null;
      });
    }
  }

  void onChangedPassword(String value) {
    if (value.isEmpty) {
      setState(() {
        passwordError = 'Digite uma senha';
      });
    } else {
      setState(() {
        password = value;
        passwordError = null;
      });
    }
  }

  void login(BuildContext context) {
    if (emailError != null || passwordError != null || email.isEmpty || password.isEmpty) {
      return;
    }
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Logado com sucesso'),
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
              TextField(
                decoration: InputDecoration(
                  border: const OutlineInputBorder(),
                  hintText: 'Ex.: email@provedor.com',
                  label: const Text('E-mail'),
                  errorText: emailError,
                  //suffix: Icon(Icons.hide_source),
                ),
                onChanged: onChangedEmail,
              ),
              const SizedBox(height: 20),
              TextField(
                decoration: InputDecoration(
                  border: const OutlineInputBorder(),
                  hintText: 'Ex.: suasenha123',
                  label: const Text('Senha'),
                  errorText: passwordError,
                  //suffix: Icon(Icons.hide_source),
                ),
                onChanged: onChangedPassword,
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                style: ButtonStyle(minimumSize: MaterialStateProperty.all(Size(max(size.width * 0.1, 120), max(size.width * 0.01, 60)))),
                onPressed: () => login(context),
                child: const Text('Login'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
