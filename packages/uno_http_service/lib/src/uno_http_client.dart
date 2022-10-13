import 'package:core/core.dart';
import 'package:dependencies/dependencies.dart';

class UnoHttpClient extends HttpService {
  final _uno = Uno();

  @override
  Future<HttpResponse> get({required String path}) async {
    try {
      final response = await _uno.get(path);
      return HttpResponse(message: 'OK', statusCode: response.status);
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}
