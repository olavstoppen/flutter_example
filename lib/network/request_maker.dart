import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter_example/domain/response/request_response.dart';

class RequestMaker {
  static RequestMaker instance = RequestMaker();

  final Dio _dio;
  RequestMaker()
      : _dio = Dio(BaseOptions(headers: {
          'Accept': 'application/json',
          'Content-Type': 'application/json',
        }));

  Future<RequestResponse> get(String url, {Map<String, String>? headers}) async {
    try {
      final Response response = await _dio.get(
        url,
        options: Options(
          responseType: ResponseType.json,
        ),
      );

      return handleResponse(response);
    } catch (e) {
      return createErrorFromException('GET', e as Exception);
    }
  }

  RequestResponse handleResponse(Response response) {
    final code = response.statusCode ?? 500;
    if (code == 200) {
      final body = response.data;
      return RequestResponse(
        code,
        body ?? <String, dynamic>{},
      );
    } else {
      return createError(
        code,
        response.statusMessage ?? "Something went wrong",
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
