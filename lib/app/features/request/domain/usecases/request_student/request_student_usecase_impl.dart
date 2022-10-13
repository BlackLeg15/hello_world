import '../../params/request_student_params.dart';
import '../../repositories/request_student_repository.dart';
import '../../typedefs/request_student_typedef.dart';
import 'request_student_usecase.dart';

class RequestStudentUsecaseImpl extends RequestStudentUsecase {
  final RequestStudentRepository _repository;

  RequestStudentUsecaseImpl(this._repository);

  @override
  RequestStudentResult requestStudent({required RequestStudentParams params}) {
    return _repository.requestStudent(params: params);
  }
}
