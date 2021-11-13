import 'package:flutter_example/domain/response/base_response.dart';
import 'package:flutter_example/domain/project.dart';
import 'package:flutter_example/utils/parser.dart';

class ProjectsResponse extends BaseResponse {
  final List<Project> projects;

  ProjectsResponse({
    required dynamic json,
    required int code,
    required this.projects,
    String? error,
  }) : super(
    code: code,
    json: json,
  );

  factory ProjectsResponse.fromJson({
    required dynamic json,
    required int code,
    String? error,
  }) {
    return ProjectsResponse(
        json: json,
        code: code,
        error: error,
        projects: Parser.getList(json, 'projects').map((e) => Project.fromJson(json: e)).toList()
    );
  }
}