import 'package:flutter_example/utils/parser.dart';

class Project {
  final String name;
  final String description;
  final String thumbnail;

  Project({
    required this.name,
    required this.description,
    required this.thumbnail,
  });

  factory Project.fromJson({required Map<String,dynamic> json}) {
    return Project(
        name: Parser.getString(json, 'name'),
        description: Parser.getString(json, 'description'),
        thumbnail: Parser.getString(json, 'thumbnail'),
    );
  }
}