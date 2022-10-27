import 'package:dependencies/dependencies.dart';
part 'form_store.g.dart';

class FormStore = FormStoreBase with _$FormStore;

abstract class FormStoreBase with Store {
  @observable
  String email = '';

  @observable
  String password = '';

  @observable
  String? emailError;

  @observable
  String? passwordError;

  @action
  void changeEmail(String value) {
    if (value.isEmpty) {
      emailError = 'Digite um e-mail';
    } else {
      email = value;
      emailError = null;
    }
  }

  @action
  void changePassword(String value) {
    if (value.isEmpty) {
      passwordError = 'Digite uma senha';
    } else {
      password = value;
      passwordError = null;
    }
  }

  @computed
  bool get isValid => emailError == null && passwordError == null && email.isNotEmpty && password.isNotEmpty;
}
