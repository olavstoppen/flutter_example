class Parser {
  static String getString(Map<String, dynamic>? obj, String key) {
    if (obj == null) return "";
    if (!obj.containsKey(key)) {
      return "";
    }
    final res = obj[key];
    if (res is String) {
      return res;
    }
    if (res is num) {
      return res.toString();
    }
    return "";
  }

  static List getList(Map<String, dynamic>? obj, String key) {
    if (obj == null) return [];
    final list = obj[key];
    if (list is List) {
      return list;
    }
    return [];
  }
}
