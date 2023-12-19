class HttpRequestException implements Exception {
  String message;

  HttpRequestException(this.message);

  @override
  String toString() {
    return "HttpRequestException: $message";
  }
}
