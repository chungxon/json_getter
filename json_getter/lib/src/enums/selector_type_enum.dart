import 'package:dart_mappable/dart_mappable.dart';

import '../utils/type_utils.dart';

part 'selector_type_enum.mapper.dart';

@MappableEnum()
enum SelectorType {
  getValueByKey, // For map only
  getAllKeys, // For map only
  getAllValues, // For map only
  getLength, // For both list and map
  getValueFromWhere, // Filter map with condition by key or value, loop all items in list to get value with condition by key or value
  getValueAt, // For list only
  getValueFirst, // For list only
  getValueLast, // For list only
  join, // For list string only
  getItemsFromWhere, // For list only
  ;

  static List<SelectorType> getSupportSelectorTypes(dynamic json) {
    if (TypeUtils.isList<String>(json)) {
      return [
        SelectorType.getLength,
        SelectorType.getValueAt,
        SelectorType.getValueFirst,
        SelectorType.getValueLast,
        SelectorType.getValueFromWhere,
        SelectorType.join,
      ];
    } else if (json is List) {
      return [
        SelectorType.getLength,
        SelectorType.getValueAt,
        SelectorType.getValueFirst,
        SelectorType.getValueLast,
        SelectorType.getValueFromWhere,
        SelectorType.getItemsFromWhere,
      ];
    } else if (json is Map) {
      return [
        SelectorType.getValueByKey,
        SelectorType.getAllKeys,
        SelectorType.getAllValues,
        SelectorType.getLength,
        SelectorType.getValueFromWhere,
        SelectorType.getItemsFromWhere,
      ];
    }
    return [];
  }
}

extension SelectorTypeExtension on SelectorType {
  String get title {
    switch (this) {
      case SelectorType.getValueByKey:
        return 'Get Value By Key';
      case SelectorType.getAllKeys:
        return 'Get All Keys';
      case SelectorType.getAllValues:
        return 'Get All Values';
      case SelectorType.getLength:
        return 'Get Length';
      case SelectorType.getValueFromWhere:
        return 'Get Value From Where';
      case SelectorType.getValueAt:
        return 'Get Value At';
      case SelectorType.getValueFirst:
        return 'Get Value First';
      case SelectorType.getValueLast:
        return 'Get Value Last';
      case SelectorType.join:
        return 'Join';
      case SelectorType.getItemsFromWhere:
        return 'Get Items From Where';
    }
  }
}
