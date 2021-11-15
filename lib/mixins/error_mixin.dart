
import 'package:flutter_example/domain/response/base_response.dart';

mixin ErrorMixin {

  bool isSuccessful(BaseResponse response) {
    return response.successful;
  }

  String createErrorFromResponse(BaseResponse response) {
    return response.error ?? "Something went wrong";
  }
}
