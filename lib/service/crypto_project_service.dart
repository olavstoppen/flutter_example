import 'package:flutter_example/domain/response/projects_response.dart';
import 'package:flutter_example/domain/response/request_response.dart';
import 'package:flutter_example/network/request_maker.dart';
import 'package:flutter_example/network/urls.dart';

class CryptoProjectService {
  static CryptoProjectService instance = CryptoProjectService();
  final ApiUrls urls = ApiUrls();

  Future<ProjectsResponse> getCryptoProjects() async {
    final RequestResponse res = await RequestMaker.instance.get(urls.cryptoProjects);
    return ProjectsResponse.fromJson(json: res.body, code: res.code);
  }
}
