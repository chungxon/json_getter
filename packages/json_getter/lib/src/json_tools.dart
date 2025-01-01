import 'enums/enums.dart';
import 'models/models.dart';
import 'utils/utils.dart';

/// JSON tools used for JSON Getter
class JsonTools {
  /// Get all keys from dynamic
  static List<dynamic> getAllKeys(dynamic json) {
    if (json is Map) {
      return json.keys.toList();
    } else if (json is List) {
      // Get all keys in a list
      final keys = <dynamic>[];
      for (var i = 0; i < json.length; i++) {
        keys.addAll(getAllKeys(json[i]));
      }
      // Return unique keys as list String
      final uniqueKeys = keys.toSet().map((e) => e.toString()).toList();
      return uniqueKeys;
    } else if (json is String) {
      return [json];
    }

    return [];
  }

  /// Get all values from dynamic
  static List<dynamic> getAllValues(dynamic json) {
    if (json is Map) {
      return json.values.toList();
    } else if (json is List) {
      // Get all values in a list
      final values = <dynamic>[];
      for (var i = 0; i < json.length; i++) {
        values.addAll(getAllValues(json[i]));
      }
      return values;
    } else if (json is String) {
      return [json];
    }

    return [];
  }

  /// Get length from dynamic
  static int getLength(dynamic json) {
    if (json is List) {
      return json.length;
    } else if (json is Map) {
      return json.length;
    } else if (json is String) {
      return json.length;
    }

    return 0;
  }

  /// Get value by key from dynamic
  static dynamic getValueByKey(dynamic json, String? key) {
    if (json is Map) {
      if (key != null && key.isNotEmpty && json.containsKey(key)) {
        return json[key];
      }
    } else if (json is List) {
      final data = [];
      for (var i = 0; i < json.length; i++) {
        final value = getValueByKey(json[i], key);
        if (value != null) {
          data.add(value);
        }
      }
      return data;
    } else if (json is String) {
      return json;
    }

    return null;
  }

  /// Get value at index from dynamic
  static dynamic getValueAt(dynamic json, dynamic index) {
    final newIndex = int.tryParse(index.toString());

    if (json is List) {
      if (newIndex != null && newIndex >= 0 && newIndex < json.length) {
        return json[newIndex];
      }
    }

    return null;
  }

  /// Get value first from dynamic
  static dynamic getValueFirst(dynamic json) {
    if (json is List) {
      if (json.isNotEmpty) {
        return json.first;
      }
    }

    return null;
  }

  /// Get value last from dynamic
  static dynamic getValueLast(dynamic json) {
    if (json is List) {
      if (json.isNotEmpty) {
        return json.last;
      }
    }

    return null;
  }

  /// Get value from where from dynamic with operator
  static dynamic getValueFromWhere(
    dynamic json,
    Filter filter,
  ) {
    if (filter.filterBy?.isByValue ?? false) {
      final jsonValue = JsonTools.getValueByKey(
        json,
        filter.key ?? '',
      );
      final dataType = DataType.getType(jsonValue);
      if (dataType == DataType.string) {
        return _getValueFromWhereString(jsonValue, filter);
      } else if (dataType == DataType.number) {
        return _getValueFromWhereNumber(jsonValue, filter);
      } else if (dataType == DataType.boolean) {
        return _getValueFromWhereBoolean(jsonValue, filter);
      } else if (dataType == DataType.list) {
        return _getValueFromWhereList(jsonValue, filter);
      } else if (dataType == DataType.map) {
        return _getValueFromWhereMap(jsonValue, filter);
      }
    }

    return _getValueFromWhereByKey(json, filter);
  }

  /// Get value from where from String with operator
  static String? _getValueFromWhereString(
    String json,
    Filter filter,
  ) {
    final operator = filter.operator;
    final value = filter.value;

    switch (operator) {
      case Operator.equal:
        if (json == value) {
          return json;
        }
      case Operator.notEqual:
        if (json != value) {
          return json;
        }
      case Operator.contains:
        if (json.contains(value.toString())) {
          return json;
        }
      case Operator.notContains:
        if (!json.contains(value.toString())) {
          return json;
        }
      case Operator.startsWith:
        if (json.startsWith(value.toString())) {
          return json;
        }
      case Operator.notStartsWith:
        if (!json.startsWith(value.toString())) {
          return json;
        }
      case Operator.endsWith:
        if (json.endsWith(value.toString())) {
          return json;
        }
      case Operator.notEndsWith:
        if (!json.endsWith(value.toString())) {
          return json;
        }
      case Operator.isEmpty:
        if (json.isEmpty) {
          return json;
        }
      case Operator.isNotEmpty:
        if (json.isNotEmpty) {
          return json;
        }
      case Operator.greaterThan:
      case Operator.greaterThanOrEqual:
      case Operator.lessThan:
      case Operator.lessThanOrEqual:
      default:
        return null;
    }
    return null;
  }

  /// Get value from where from number with operator
  static num? _getValueFromWhereNumber(
    num json,
    Filter filter,
  ) {
    final operator = filter.operator;
    final value = filter.value;

    switch (operator) {
      case Operator.equal:
        if (json == value) {
          return json;
        }
      case Operator.notEqual:
        if (json != value) {
          return json;
        }
      case Operator.contains:
      case Operator.notContains:
      case Operator.startsWith:
      case Operator.notStartsWith:
      case Operator.endsWith:
      case Operator.notEndsWith:
      case Operator.isEmpty:
        if (json.toString().isEmpty) {
          return json;
        }
      case Operator.isNotEmpty:
        if (json.toString().isNotEmpty) {
          return json;
        }
      case Operator.greaterThan:
        if (json > value) {
          return json;
        }
      case Operator.greaterThanOrEqual:
        if (json >= value) {
          return json;
        }
      case Operator.lessThan:
        if (json < value) {
          return json;
        }
      case Operator.lessThanOrEqual:
        if (json <= value) {
          return json;
        }
      default:
        return null;
    }
    return null;
  }

  /// Get value from where from boolean with operator
  static bool? _getValueFromWhereBoolean(
    bool json,
    Filter filter,
  ) {
    final operator = filter.operator;
    final value = filter.value;

    switch (operator) {
      case Operator.equal:
        if (json == value) {
          return json;
        }
      case Operator.notEqual:
        if (json != value) {
          return json;
        }
      case Operator.contains:
      case Operator.notContains:
      case Operator.startsWith:
      case Operator.notStartsWith:
      case Operator.endsWith:
      case Operator.notEndsWith:
      case Operator.isEmpty:
      case Operator.isNotEmpty:
      case Operator.greaterThan:
      case Operator.greaterThanOrEqual:
      case Operator.lessThan:
      case Operator.lessThanOrEqual:
      default:
        return null;
    }
    return null;
  }

  /// Get value from where from list with operator
  static List? _getValueFromWhereList(
    List json,
    Filter filter,
  ) {
    final operator = filter.operator;
    final value = filter.value;

    switch (operator) {
      case Operator.equal:
        if (TypeUtils.isList<String>(json)) {
          final results = [];
          for (var i = 0; i < json.length; i++) {
            if (json[i] == value) {
              results.add(json[i]);
            }
          }
          return results;
        }
      case Operator.notEqual:
        if (TypeUtils.isList<String>(json)) {
          final results = [];
          for (var i = 0; i < json.length; i++) {
            if (json[i] != value) {
              results.add(json[i]);
            }
          }
          return results;
        }
      case Operator.contains:
        if (TypeUtils.isList<String>(json)) {
          final results = [];
          for (var i = 0; i < json.length; i++) {
            if (json[i].toString().contains(value.toString())) {
              results.add(json[i]);
            }
          }
          return results;
        }
      case Operator.notContains:
        if (TypeUtils.isList<String>(json)) {
          final results = [];
          for (var i = 0; i < json.length; i++) {
            if (!json[i].toString().contains(value.toString())) {
              results.add(json[i]);
            }
          }
          return results;
        }
      case Operator.startsWith:
        if (TypeUtils.isList<String>(json)) {
          final results = [];
          for (var i = 0; i < json.length; i++) {
            if (json[i].toString().startsWith(value.toString())) {
              results.add(json[i]);
            }
          }
          return results;
        }
      case Operator.notStartsWith:
        if (TypeUtils.isList<String>(json)) {
          final results = [];
          for (var i = 0; i < json.length; i++) {
            if (!json[i].toString().startsWith(value.toString())) {
              results.add(json[i]);
            }
          }
          return results;
        }
      case Operator.endsWith:
        if (TypeUtils.isList<String>(json)) {
          final results = [];
          for (var i = 0; i < json.length; i++) {
            if (json[i].toString().endsWith(value.toString())) {
              results.add(json[i]);
            }
          }
          return results;
        }
      case Operator.notEndsWith:
        if (TypeUtils.isList<String>(json)) {
          final results = [];
          for (var i = 0; i < json.length; i++) {
            if (!json[i].toString().endsWith(value.toString())) {
              results.add(json[i]);
            }
          }
          return results;
        }
      case Operator.isEmpty:
        if (json.isEmpty) {
          return json;
        }
      case Operator.isNotEmpty:
        if (json.isNotEmpty) {
          return json;
        }
      case Operator.greaterThan:
      case Operator.greaterThanOrEqual:
      case Operator.lessThan:
      case Operator.lessThanOrEqual:
      default:
        return null;
    }
    return null;
  }

  /// Get value from where from map with operator
  static Map? _getValueFromWhereMap(
    Map json,
    Filter filter,
  ) {
    final operator = filter.operator;

    switch (operator) {
      case Operator.equal:
      case Operator.notEqual:
      case Operator.contains:
      case Operator.notContains:
      case Operator.startsWith:
      case Operator.notStartsWith:
      case Operator.endsWith:
      case Operator.notEndsWith:
        return null;
      case Operator.isEmpty:
        if (json.isEmpty) {
          return json;
        }
      case Operator.isNotEmpty:
        if (json.isNotEmpty) {
          return json;
        }
      case Operator.greaterThan:
      case Operator.greaterThanOrEqual:
      case Operator.lessThan:
      case Operator.lessThanOrEqual:
      default:
        return null;
    }
    return null;
  }

  /// Get value from where from key of map with operator
  static dynamic _getValueFromWhereByKey(
    dynamic json,
    Filter filter,
  ) {
    final operator = filter.operator;
    final key = filter.key;

    if (key == null) {
      return null;
    }

    switch (operator) {
      case Operator.equal:
        if (json is Map) {
          return json[key];
        } else if (json is List) {
          final data = [];
          for (var i = 0; i < json.length; i++) {
            data.add(_getValueFromWhereByKey(json[i], filter));
          }
          data.removeWhere((json) => json == null);
          return data;
        } else if (json is String) {
          if (json == key) {
            return json;
          }
          return null;
        }
      case Operator.notEqual:
        if (json is Map) {
          // Do not handle it because it can return many values
        } else if (json is List) {
          final data = [];
          for (var i = 0; i < json.length; i++) {
            data.add(_getValueFromWhereByKey(json[i], filter));
          }
          data.removeWhere((json) => json == null);
          return data;
        } else if (json is String) {
          if (json != key) {
            return json;
          }
          return null;
        }

      case Operator.contains:
        if (json is Map) {
          // Do not handle it because it can return many values
        } else if (json is List) {
          final data = [];
          for (var i = 0; i < json.length; i++) {
            data.add(_getValueFromWhereByKey(json[i], filter));
          }
          data.removeWhere((json) => json == null);
          return data;
        } else if (json is String) {
          if (json.contains(key)) {
            return json;
          }
          return null;
        }
      case Operator.notContains:
        if (json is Map) {
          // Do not handle it
        } else if (json is List) {
          final data = [];
          for (var i = 0; i < json.length; i++) {
            data.add(_getValueFromWhereByKey(json[i], filter));
          }
          data.removeWhere((json) => json == null);
          return data;
        } else if (json is String) {
          if (!json.contains(key)) {
            return json;
          }
          return null;
        }
      case Operator.startsWith:
      case Operator.notStartsWith:
      case Operator.endsWith:
      case Operator.notEndsWith:
      case Operator.isEmpty:
      case Operator.isNotEmpty:
      case Operator.greaterThan:
      case Operator.greaterThanOrEqual:
      case Operator.lessThan:
      case Operator.lessThanOrEqual:
      default:
        return null;
    }
    return null;
  }

  /// Get items from where from dynamic with operator
  static dynamic getItemsFromWhere(
    dynamic json,
    Filter filter,
  ) {
    if (filter.filterBy?.isByValue ?? false) {
      if (json is List) {
        final results = [];
        for (var i = 0; i < json.length; i++) {
          final jsonItem = json[i];

          final jsonValue = JsonTools.getValueByKey(
            jsonItem,
            filter.key ?? '',
          );
          final dataType = DataType.getType(jsonValue);
          if (dataType == DataType.string) {
            if (_getValueFromWhereString(jsonValue, filter) != null) {
              results.add(jsonItem);
            }
          } else if (dataType == DataType.number) {
            if (_getValueFromWhereNumber(jsonValue, filter) != null) {
              results.add(jsonItem);
            }
          } else if (dataType == DataType.boolean) {
            if (_getValueFromWhereBoolean(jsonValue, filter) != null) {
              results.add(jsonItem);
            }
            // Cannot have List in List
            // } else if (dataType == DataType.list) {
          } else if (dataType == DataType.map) {
            if (_getValueFromWhereMap(jsonValue, filter) != null) {
              results.add(jsonItem);
            }
          }
        }
        return results;
      } else if (json is Map) {
        final results = {};
        for (final key in json.keys) {
          final jsonValue = json[key];
          final dataType = DataType.getType(jsonValue);
          if (dataType == DataType.string) {
            if (_getValueFromWhereString(jsonValue, filter) != null) {
              results[key] = json[key];
            }
          } else if (dataType == DataType.number) {
            if (_getValueFromWhereNumber(jsonValue, filter) != null) {
              results[key] = json[key];
            }
          } else if (dataType == DataType.boolean) {
            if (_getValueFromWhereBoolean(jsonValue, filter) != null) {
              results[key] = json[key];
            }
          } else if (dataType == DataType.list) {
            if (_getValueFromWhereList(jsonValue, filter) != null) {
              results[key] = json[key];
            }
          } else if (dataType == DataType.map) {
            if (_getValueFromWhereMap(jsonValue, filter) != null) {
              results[key] = json[key];
            }
          }
        }
        return results;
      }
    }

    return _getItemsFromWhereByKey(json, filter);
  }

  static dynamic _getItemsFromWhereByKey(
    dynamic json,
    Filter filter,
  ) {
    final operator = filter.operator;
    final key = filter.key;

    switch (operator) {
      case Operator.equal:
        if (json is Map) {
          if (json.containsKey(key.toString())) {
            return {key: json[key]};
          }
          return null;
        } else if (json is List) {
          final results = [];
          for (var i = 0; i < json.length; i++) {
            final jsonKeys = getAllKeys(json[i]);
            if (jsonKeys.any((e) => e.toString() == key.toString())) {
              results.add(json[i]);
            }
          }
          return results;
        } else if (json is String) {
          if (json == key) {
            return json;
          }
          return null;
        }
      case Operator.notEqual:
        if (json is Map) {
          final results = Map.from(json)
            ..removeWhere(
              (k, v) => k.toString() == key.toString(),
            );
          return results;
        } else if (json is List) {
          final results = [];
          for (var i = 0; i < json.length; i++) {
            final jsonKeys = getAllKeys(json[i]);
            if (jsonKeys.every((e) => e.toString() != key.toString())) {
              results.add(json[i]);
            }
          }
          return results;
        } else if (json is String) {
          if (json != key) {
            return json;
          }
          return null;
        }
      case Operator.contains:
        if (json is Map) {
          final data = {};
          json.forEach((key, value) {
            if (key.toString().contains(key)) {
              data[key] = value;
            }
          });
          return data;
        } else if (json is List) {
          final results = [];
          for (var i = 0; i < json.length; i++) {
            final jsonKeys = getAllKeys(json[i]);
            if (jsonKeys.any((e) => e.toString().contains(key.toString()))) {
              results.add(json[i]);
            }
          }
          return results;
        } else if (json is String) {
          if (key != null && key.isNotEmpty && json.contains(key)) {
            return json;
          }
          return null;
        }
      case Operator.notContains:
        if (json is Map) {
          final data = {};
          json.forEach((k, v) {
            if (!k.toString().contains(key.toString())) {
              data[k] = v;
            }
          });
          return data;
        } else if (json is List) {
          final results = [];
          for (var i = 0; i < json.length; i++) {
            final jsonKeys = getAllKeys(json[i]);
            if (jsonKeys.every((e) => !e.toString().contains(key.toString()))) {
              results.add(json[i]);
            }
          }
          return results;
        } else if (json is String) {
          if (key != null && key.isNotEmpty && !json.contains(key)) {
            return json;
          }
          return null;
        }
      case Operator.startsWith:
      case Operator.notStartsWith:
      case Operator.endsWith:
      case Operator.notEndsWith:
      case Operator.isEmpty:
        if (json is Map) {
        } else if (json is List) {
          final results = [];
          for (var i = 0; i < json.length; i++) {
            if (!TypeUtils.isNotEmptyJson(json[i])) {
              results.add(json[i]);
            }
          }
          return results;
        } else if (json is String) {}
      case Operator.isNotEmpty:
        if (json is Map) {
        } else if (json is List) {
          final results = [];
          for (var i = 0; i < json.length; i++) {
            if (TypeUtils.isNotEmptyJson(json[i])) {
              results.add(json[i]);
            }
          }
          return results;
        } else if (json is String) {}
      case Operator.greaterThan:
      case Operator.greaterThanOrEqual:
      case Operator.lessThan:
      case Operator.lessThanOrEqual:
      default:
        return null;
    }
  }
}
