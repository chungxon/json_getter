import 'dart:convert';

class TypeUtils {
  /// Check is json
  static bool isJson(dynamic json) {
    try {
      dynamic data = json;
      if (json is String) {
        data = jsonDecode(json);
      }

      return data is Map || data is List;
    } catch (e) {
      return false;
    }
  }

  /// Check is not empty json
  static bool isNotEmptyJson(dynamic json) {
    try {
      dynamic data = json;
      if (json is String) {
        data = jsonDecode(json);
      }

      if (data is Map) {
        return data.isNotEmpty;
      } else if (data is List) {
        return data.isNotEmpty;
      }
      return false;
    } catch (e) {
      return false;
    }
  }

  /// Parse json from dynamic
  static dynamic tryParseJson(dynamic json) {
    try {
      return jsonDecode(json);
    } catch (e) {
      return null;
    }
  }

  static bool isList<T>(dynamic list) {
    return (list is List) && (list.every((e) => e is T));
  }

  static bool isMap<T>(dynamic map) {
    return (map is Map) && (map.values.every((e) => e is T));
  }

  static String joinList(dynamic json, String? separator) {
    if (json is List) {
      return json.join(separator ?? '');
    }

    return '';
  }
}
