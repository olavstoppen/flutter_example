import 'dart:io';
import 'dart:convert';

import 'package:http/http.dart' as http;

import 'package:flutter_example/domain/response/request_response.dart';

class RequestMaker {

  static RequestMaker instance = RequestMaker();

  final JsonDecoder decoder = const JsonDecoder();

  final Map<String, String> defaultHeaders = {
    'Accept': 'application/json',
    'Content-Type': 'application/json',
  };

  Future<RequestResponse> get(String url, {Map<String, String>? headers}) async {
    try {
      final response = await http.get(
          Uri.parse(url),
          headers: headers ?? defaultHeaders);
      return handleResponse(response);
    } catch (e) {
      return createErrorFromException('GET', e as Exception);
    }
  }

  RequestResponse handleResponse(http.Response response) {
    final code = response.statusCode;
    if (code == 200) {
      final body = response.body;
      final resp = decoder.convert(body);
      return RequestResponse(
        code,
        resp ?? <String, dynamic>{},
      );
    } else {
      return createError(
        response.statusCode,
        response.reasonPhrase ?? "Something went wrong",
      );
    }
  }

  RequestResponse createError(int code, String error) {
    return RequestResponse(
      code,
      {'code': code, 'error': error},
    );
  }

  RequestResponse createErrorFromException(String tag, Exception e) {
    if (e is SocketException) {
      return createError(
        408,
        'No connection',
      );
    }
    return createError(
      500,
      'Internal request failure',
    );
  }
}