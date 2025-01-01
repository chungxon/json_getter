// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'operator_enum.dart';

class OperatorMapper extends EnumMapper<Operator> {
  OperatorMapper._();

  static OperatorMapper? _instance;
  static OperatorMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = OperatorMapper._());
    }
    return _instance!;
  }

  static Operator fromValue(dynamic value) {
    ensureInitialized();
    return MapperContainer.globals.fromValue(value);
  }

  @override
  Operator decode(dynamic value) {
    switch (value) {
      case 'equal':
        return Operator.equal;
      case 'notEqual':
        return Operator.notEqual;
      case 'contains':
        return Operator.contains;
      case 'notContains':
        return Operator.notContains;
      case 'startsWith':
        return Operator.startsWith;
      case 'notStartsWith':
        return Operator.notStartsWith;
      case 'endsWith':
        return Operator.endsWith;
      case 'notEndsWith':
        return Operator.notEndsWith;
      case 'isEmpty':
        return Operator.isEmpty;
      case 'isNotEmpty':
        return Operator.isNotEmpty;
      case 'greaterThan':
        return Operator.greaterThan;
      case 'greaterThanOrEqual':
        return Operator.greaterThanOrEqual;
      case 'lessThan':
        return Operator.lessThan;
      case 'lessThanOrEqual':
        return Operator.lessThanOrEqual;
      default:
        throw MapperException.unknownEnumValue(value);
    }
  }

  @override
  dynamic encode(Operator self) {
    switch (self) {
      case Operator.equal:
        return 'equal';
      case Operator.notEqual:
        return 'notEqual';
      case Operator.contains:
        return 'contains';
      case Operator.notContains:
        return 'notContains';
      case Operator.startsWith:
        return 'startsWith';
      case Operator.notStartsWith:
        return 'notStartsWith';
      case Operator.endsWith:
        return 'endsWith';
      case Operator.notEndsWith:
        return 'notEndsWith';
      case Operator.isEmpty:
        return 'isEmpty';
      case Operator.isNotEmpty:
        return 'isNotEmpty';
      case Operator.greaterThan:
        return 'greaterThan';
      case Operator.greaterThanOrEqual:
        return 'greaterThanOrEqual';
      case Operator.lessThan:
        return 'lessThan';
      case Operator.lessThanOrEqual:
        return 'lessThanOrEqual';
    }
  }
}

extension OperatorMapperExtension on Operator {
  String toValue() {
    OperatorMapper.ensureInitialized();
    return MapperContainer.globals.toValue<Operator>(this) as String;
  }
}
