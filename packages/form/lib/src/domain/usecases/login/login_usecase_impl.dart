import 'package:form/src/domain/repositories/login_repository.dart';
import 'package:form/src/domain/typedef/login_typedef.dart';
import 'package:form/src/domain/params/login_params.dart';
import 'package:form/src/domain/usecases/login/login_usecase.dart';

class LoginUsecaseImpl extends LoginUsecase {
  final LoginRepository _repository;

  const LoginUsecaseImpl(this._repository);

  @override
  LoginResult call(LoginParams params) {
    return _repository(params);
  }
}
