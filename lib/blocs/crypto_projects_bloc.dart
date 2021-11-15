import 'package:flutter_example/domain/project.dart';
import 'package:flutter_example/domain/response/projects_response.dart';
import 'package:flutter_example/mixins/error_mixin.dart';
import 'package:flutter_example/utils/request_maker.dart';
import 'package:rxdart/rxdart.dart';

class CryptoProjectsBloc with ErrorMixin {

  CryptoProjectsBloc() {
    _projectSubject = PublishSubject<List<Project>>();
  }
  
  Stream<List<Project>> get projectsStream => _projectSubject.stream;
  
  late PublishSubject<List<Project>> _projectSubject;

  void fetchCryptoProjects() async {
    final res = await RequestMaker.instance.get("https://detoxer.github.io/neo_hub_json_store/json/projects/platform_projects.json");
    final cryptoRes = ProjectsResponse.fromJson(json: res.body, code: res.code);
    if(isSuccessful(cryptoRes)) {
      _projectSubject.sink.add(cryptoRes.projects);
    } else {
      _projectSubject.addError(createErrorFromResponse(cryptoRes));
    }
  }

  void dispose() {
    _projectSubject.close();
  }
}