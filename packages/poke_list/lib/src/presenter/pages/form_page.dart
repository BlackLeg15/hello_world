// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:poke_list/src/presenter/pages/form_controller.dart';

class FormPage extends StatefulWidget {
  final FormController formController;
  const FormPage({
    Key? key,
    required this.formController,
  }) : super(key: key);

  @override
  State<FormPage> createState() => _FormPageState();
}

class _FormPageState extends State<FormPage> {
  late FormController formController;

  @override
  void didChangeDependencies() {
    formController = widget.formController;
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    formController.firstName = '';
    formController.lastName = '';
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextField(
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  label: Text('First name'),
                ),
                onChanged: (value) {
                  formController.firstName = value;
                },
              ),
              const SizedBox(height: 15),
              TextField(
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  label: Text('Last name'),
                ),
                onChanged: (value) {
                  formController.lastName = value;
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
