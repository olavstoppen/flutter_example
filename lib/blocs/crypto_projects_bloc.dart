import 'package:flutter_example/domain/project.dart';
import 'package:flutter_example/domain/response/projects_response.dart';
import 'package:flutter_example/domain/stream_object.dart';
import 'package:flutter_example/mixins/error_mixin.dart';
import 'package:flutter_example/service/crypto_project_service.dart';
import 'package:rxdart/rxdart.dart';

class CryptoProjectsBloc with ErrorMixin {
  final BehaviorSubject<StreamListObject<Project>> _projectSubject;

  Stream<StreamListObject<Project>> get projectsStream => _projectSubject.stream;

  CryptoProjectsBloc()
      : _projectSubject = BehaviorSubject<StreamListObject<Project>>.seeded(
          const StreamListObject(
            state: StreamObjectState.loading,
            payload: [],
          ),
        );

  void fetchCryptoProjects() async {
    final ProjectsResponse cryptoRes = await CryptoProjectService.instance.getCryptoProjects();
    if (isSuccessful(cryptoRes)) {
      _projectSubject.sink.add(
        StreamListObject(
          state: StreamObjectState.success,
          payload: cryptoRes.projects,
        ),
      );
    } else {
      _projectSubject.sink.add(
        StreamListObject(
          state: StreamObjectState.error,
          errorMessage: createErrorFromResponse(cryptoRes),
          payload: [],
        ),
      );
    }
  }

  void dispose() {
    _projectSubject.close();
  }
}
