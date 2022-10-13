import 'package:dependencies/dependencies.dart';

import '../entities/student_entity.dart';

typedef RequestStudentResult = Future<Either<Exception, StudentEntity>>;
