class HttpResponse {
  final String message;
  final int statusCode;
  final dynamic data;

  const HttpResponse({required this.message, required this.statusCode, required this.data});
}
