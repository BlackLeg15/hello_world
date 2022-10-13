import 'package:form/src/domain/entities/login_entity.dart';
import 'package:dependencies/dependencies.dart';
import 'package:form/src/domain/errors/login_errors.dart';

typedef LoginResult = Future<Either<LoginError, LoginEntity>>;
