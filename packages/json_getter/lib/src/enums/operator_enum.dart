import 'package:dart_mappable/dart_mappable.dart';

import '../utils/type_utils.dart';
import 'data_type_enum.dart';
import 'filter_by_enum.dart';

part 'operator_enum.mapper.dart';

@MappableEnum()
enum Operator {
  equal(
    supportOperatorTypes: [
      DataType.string,
      DataType.number,
      DataType.boolean,
      DataType.nullable,
    ],
    supportFilterBy: [FilterBy.key, FilterBy.value],
  ),
  notEqual(
    supportOperatorTypes: [
      DataType.string,
      DataType.number,
      DataType.boolean,
      DataType.nullable,
    ],
    supportFilterBy: [FilterBy.key, FilterBy.value],
  ),
  contains(
    supportOperatorTypes: [DataType.string, DataType.list],
    supportFilterBy: [FilterBy.key, FilterBy.value],
  ),
  notContains(
    supportOperatorTypes: [DataType.string, DataType.list],
    supportFilterBy: [FilterBy.key, FilterBy.value],
  ),
  startsWith(
    supportOperatorTypes: [DataType.string],
    supportFilterBy: [FilterBy.value],
  ),
  notStartsWith(
    supportOperatorTypes: [DataType.string],
    supportFilterBy: [FilterBy.value],
  ),
  endsWith(
    supportOperatorTypes: [DataType.string],
    supportFilterBy: [FilterBy.value],
  ),
  notEndsWith(
    supportOperatorTypes: [DataType.string],
    supportFilterBy: [FilterBy.value],
  ),
  isEmpty(
    supportOperatorTypes: [
      DataType.string,
      DataType.number,
      DataType.list,
      DataType.map,
    ],
    supportFilterBy: [FilterBy.value],
    isNeedValue: false,
  ),
  isNotEmpty(
    supportOperatorTypes: [
      DataType.string,
      DataType.number,
      DataType.list,
      DataType.map,
    ],
    supportFilterBy: [FilterBy.value],
    isNeedValue: false,
  ),
  greaterThan(
    supportOperatorTypes: [DataType.number],
    supportFilterBy: [FilterBy.value],
  ),
  greaterThanOrEqual(
    supportOperatorTypes: [DataType.number],
    supportFilterBy: [FilterBy.value],
  ),
  lessThan(
    supportOperatorTypes: [DataType.number],
    supportFilterBy: [FilterBy.value],
  ),
  lessThanOrEqual(
    supportOperatorTypes: [DataType.number],
    supportFilterBy: [FilterBy.value],
  ),
  ;

  const Operator({
    this.supportOperatorTypes = const [],
    this.supportFilterBy = const [],
    this.isNeedValue = true,
  });

  final List<DataType> supportOperatorTypes;
  final List<FilterBy> supportFilterBy;
  final bool isNeedValue;

  static List<Operator> getSupportOperators(dynamic json, FilterBy? filterBy) {
    if (json is String) {
      return Operator.values
          .where(
            (e) =>
                e.supportOperatorTypes.contains(DataType.string) &&
                e.supportFilterBy.contains(filterBy),
          )
          .toList();
    } else if (json is num) {
      return Operator.values
          .where(
            (e) =>
                e.supportOperatorTypes.contains(DataType.number) &&
                e.supportFilterBy.contains(filterBy),
          )
          .toList();
    } else if (json is bool) {
      return Operator.values
          .where(
            (e) =>
                e.supportOperatorTypes.contains(DataType.boolean) &&
                e.supportFilterBy.contains(filterBy),
          )
          .toList();
    } else if (json is List) {
      if (TypeUtils.isList<String>(json)) {
        return Operator.values
            .where(
              (e) =>
                  e.supportOperatorTypes.contains(DataType.list) &&
                  e.supportFilterBy.contains(filterBy),
            )
            .toList()
          ..addAll([Operator.equal, Operator.notEqual]);
      }

      return Operator.values
          .where(
            (e) =>
                e.supportOperatorTypes.contains(DataType.list) &&
                e.supportFilterBy.contains(filterBy),
          )
          .toList()
        ..removeWhere(
          (e) => [Operator.contains, Operator.notContains].contains(e),
        );
    } else if (json is Map) {
      return Operator.values
          .where(
            (e) =>
                e.supportOperatorTypes.contains(DataType.map) &&
                e.supportFilterBy.contains(filterBy),
          )
          .toList();
    }
    return Operator.values;
  }
}

extension OperatorExtension on Operator {
  String get title {
    switch (this) {
      case Operator.equal:
        return 'Equal';
      case Operator.notEqual:
        return 'Not Equal';
      case Operator.contains:
        return 'Contains';
      case Operator.notContains:
        return 'Not Contains';
      case Operator.startsWith:
        return 'Starts With';
      case Operator.notStartsWith:
        return 'Not Starts With';
      case Operator.endsWith:
        return 'Ends With';
      case Operator.notEndsWith:
        return 'Not Ends With';
      case Operator.isEmpty:
        return 'Is Empty';
      case Operator.isNotEmpty:
        return 'Is Not Empty';
      case Operator.greaterThan:
        return 'Greater Than';
      case Operator.greaterThanOrEqual:
        return 'Greater Than Or Equal';
      case Operator.lessThan:
        return 'Less Than';
      case Operator.lessThanOrEqual:
        return 'Less Than Or Equal';
    }
  }
}
