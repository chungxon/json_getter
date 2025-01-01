// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'selector_type_enum.dart';

class SelectorTypeMapper extends EnumMapper<SelectorType> {
  SelectorTypeMapper._();

  static SelectorTypeMapper? _instance;
  static SelectorTypeMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = SelectorTypeMapper._());
    }
    return _instance!;
  }

  static SelectorType fromValue(dynamic value) {
    ensureInitialized();
    return MapperContainer.globals.fromValue(value);
  }

  @override
  SelectorType decode(dynamic value) {
    switch (value) {
      case 'getValueByKey':
        return SelectorType.getValueByKey;
      case 'getAllKeys':
        return SelectorType.getAllKeys;
      case 'getAllValues':
        return SelectorType.getAllValues;
      case 'getLength':
        return SelectorType.getLength;
      case 'getValueFromWhere':
        return SelectorType.getValueFromWhere;
      case 'getValueAt':
        return SelectorType.getValueAt;
      case 'getValueFirst':
        return SelectorType.getValueFirst;
      case 'getValueLast':
        return SelectorType.getValueLast;
      case 'join':
        return SelectorType.join;
      case 'getItemsFromWhere':
        return SelectorType.getItemsFromWhere;
      default:
        throw MapperException.unknownEnumValue(value);
    }
  }

  @override
  dynamic encode(SelectorType self) {
    switch (self) {
      case SelectorType.getValueByKey:
        return 'getValueByKey';
      case SelectorType.getAllKeys:
        return 'getAllKeys';
      case SelectorType.getAllValues:
        return 'getAllValues';
      case SelectorType.getLength:
        return 'getLength';
      case SelectorType.getValueFromWhere:
        return 'getValueFromWhere';
      case SelectorType.getValueAt:
        return 'getValueAt';
      case SelectorType.getValueFirst:
        return 'getValueFirst';
      case SelectorType.getValueLast:
        return 'getValueLast';
      case SelectorType.join:
        return 'join';
      case SelectorType.getItemsFromWhere:
        return 'getItemsFromWhere';
    }
  }
}

extension SelectorTypeMapperExtension on SelectorType {
  String toValue() {
    SelectorTypeMapper.ensureInitialized();
    return MapperContainer.globals.toValue<SelectorType>(this) as String;
  }
}
