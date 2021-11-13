import 'package:flutter_example/utils/parser.dart';

class BaseResponse {
  int code;
  String? error;
  Map<String, dynamic>? raw;

  BaseResponse({required this.code, Map<String, dynamic>? json}) {
    raw = json;
    error = Parser.getString(json, 'error');
  }

  bool get successful => code == 200;
}
