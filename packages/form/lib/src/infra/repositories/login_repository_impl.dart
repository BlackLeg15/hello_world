import 'package:dependencies/dependencies.dart';
import 'package:form/src/domain/errors/login_errors.dart';
import 'package:form/src/domain/params/login_params.dart';
import 'package:form/src/domain/repositories/login_repository.dart';
import 'package:form/src/domain/typedef/login_typedef.dart';
import 'package:form/src/infra/datasources/login_datasource.dart';

class LoginRepositoryImpl extends LoginRepository {
  final LoginDatasource _datasource;

  const LoginRepositoryImpl(this._datasource);

  @override
  LoginResult call(LoginParams params) async {
    try {
      final result = await _datasource(params);
      return result;
    } catch (e) {
      return const Left(LoginUnknownError(message: 'Não foi possível logar'));
    }
  }
}
