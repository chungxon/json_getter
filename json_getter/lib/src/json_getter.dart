import 'enums/enums.dart';
import 'json_tools.dart';
import 'models/models.dart';
import 'utils/utils.dart';

/// JSON Getter class for filter and get value from json by list of filters
class JsonGetter {
  /// Get value from json with list of filters
  static dynamic get({required Filters filters, required dynamic json}) {
    if (json == null) {
      return null;
    }

    dynamic result = json;

    if (json is String) {
      result = TypeUtils.tryParseJson(json);
    }
    for (var i = 0; i < filters.filters.length; i++) {
      final filter = filters.filters[i];
      result = getFromFilter(filter: filter, json: result);
    }
    return result;
  }

  /// Handle json for each filter
  static dynamic getFromFilter({
    required Filter filter,
    required dynamic json,
  }) {
    if (json == null) {
      return null;
    }

    dynamic result = json;

    if (json is String) {
      result = TypeUtils.tryParseJson(json);
    }
    switch (filter.selectorType) {
      case SelectorType.getValueByKey:
        result = JsonTools.getValueByKey(result, filter.key);
      case SelectorType.getAllKeys:
        result = JsonTools.getAllKeys(result);
      case SelectorType.getAllValues:
        result = JsonTools.getAllValues(result);
      case SelectorType.getLength:
        result = JsonTools.getLength(result);
      case SelectorType.getValueFromWhere:
        result = JsonTools.getValueFromWhere(result, filter);
      case SelectorType.getValueAt:
        result = JsonTools.getValueAt(result, filter.value);
      case SelectorType.getValueFirst:
        result = JsonTools.getValueFirst(result);
      case SelectorType.getValueLast:
        result = JsonTools.getValueLast(result);
      case SelectorType.join:
        result = TypeUtils.joinList(result, filter.value);
      case SelectorType.getItemsFromWhere:
        result = JsonTools.getItemsFromWhere(result, filter);
      default:
    }
    return result;
  }
}
