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
    email = value;
    emailError = value.isEmpty ? 'Digite um e-mail' : null;
  }

  @action
  void changePassword(String value) {
    password = value;
    passwordError = value.isEmpty ? 'Digite uma senha' : null;
  }

  @computed
  bool get isValid => emailError == null && passwordError == null && email.isNotEmpty && password.isNotEmpty;

  @observable
  bool isLoading = false;

  @action
  void changeLoading(bool value) {
    isLoading = value;
  }
}
