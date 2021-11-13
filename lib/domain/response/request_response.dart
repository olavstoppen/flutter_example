class RequestResponse {
  final int code;
  final dynamic body;

  bool get success => code == 200;

  RequestResponse(this.code, this.body);
}