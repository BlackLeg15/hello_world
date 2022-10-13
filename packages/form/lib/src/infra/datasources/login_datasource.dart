import 'package:form/src/domain/params/login_params.dart';
import 'package:form/src/domain/typedef/login_typedef.dart';

abstract class LoginDatasource {
  LoginResult call(LoginParams params);
}
