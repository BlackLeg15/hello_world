import 'http_response.dart';

abstract class HttpService {
  Future<HttpResponse> get({required String path});
}
