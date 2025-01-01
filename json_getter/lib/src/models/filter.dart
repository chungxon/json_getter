import 'package:dart_mappable/dart_mappable.dart';

import '../enums/filter_by_enum.dart';
import '../enums/operator_enum.dart';
import '../enums/selector_type_enum.dart';

part 'filter.mapper.dart';

@MappableClass()
class Filter with FilterMappable {
  const Filter({
    this.selectorType,
    this.filterBy,
    this.key,
    this.operator,
    this.value,
  });

  /// Selector Type
  final SelectorType? selectorType;

  /// Filter by
  final FilterBy? filterBy;

  /// Json Key
  final String? key;

  /// Operator
  final Operator? operator;

  /// Value
  final dynamic value;
}
