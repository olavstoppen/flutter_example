import 'package:flutter_example/utils/parser.dart';

class Project {
  final String name;
  final String description;
  final String thumbnail;
  final String banner;

  Project({
    required this.name,
    required this.description,
    required this.thumbnail,
    required this.banner,
  });

  factory Project.fromJson({required Map<String,dynamic> json}) {
    return Project(
        name: Parser.getString(json, 'name'),
        description: Parser.getString(json, 'description'),
        thumbnail: Parser.getString(json, 'thumbnail'),
        banner: Parser.getString(json, 'banner'),

    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String,dynamic>{};
    data["name"] = name;
    data["description"] = description;
    data["thumbnail"] = thumbnail;
    data["banner"] = banner;

    return data;
  }

}