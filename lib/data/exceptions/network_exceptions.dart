class NetworkException implements Exception {
  String? message;
  int? statusCode;

  NetworkException({this.message, this.statusCode});
}

class UnhandledException implements NetworkException {
  @override
  String? message;
  @override
  int? statusCode;

  UnhandledException({this.message, this.statusCode});
}