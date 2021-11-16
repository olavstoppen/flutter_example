abstract class Urls {
  String get baseUrl;
}

class ApiUrls extends Urls {

  @override
  String get baseUrl => "https://detoxer.github.io/neo_hub_json_store";

  String get cryptoProjects => "$baseUrl/json/projects/platform_projects.json";
  
}