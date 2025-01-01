import 'package:flutter_test/flutter_test.dart';
import 'package:json_getter/json_getter.dart';

void main() {
  group('Filter Class Tests', () {
    test('Can instantiate Filter with all parameters', () {
      const filter = Filter(
        selectorType: SelectorType.getValueByKey,
        filterBy: FilterBy.key,
        key: 'testKey',
        operator: Operator.equal,
        value: 'testValue',
      );

      expect(filter.selectorType, SelectorType.getValueByKey);
      expect(filter.filterBy, FilterBy.key);
      expect(filter.key, 'testKey');
      expect(filter.operator, Operator.equal);
      expect(filter.value, 'testValue');
    });

    test('Can instantiate Filter with null parameters', () {
      const filter = Filter();

      expect(filter.selectorType, isNull);
      expect(filter.filterBy, isNull);
      expect(filter.key, isNull);
      expect(filter.operator, isNull);
      expect(filter.value, isNull);
    });

    test('Filter equality and hashCode', () {
      const filter1 = Filter(
        selectorType: SelectorType.getValueByKey,
        filterBy: FilterBy.key,
        key: 'testKey',
        operator: Operator.equal,
        value: 'testValue',
      );

      const filter2 = Filter(
        selectorType: SelectorType.getValueByKey,
        filterBy: FilterBy.key,
        key: 'testKey',
        operator: Operator.equal,
        value: 'testValue',
      );

      const filter3 = Filter(
        selectorType: SelectorType.getValueAt,
        filterBy: FilterBy.value,
        key: 'anotherKey',
        operator: Operator.notEqual,
        value: 'anotherValue',
      );

      expect(filter1, equals(filter2));
      expect(filter1.hashCode, equals(filter2.hashCode));
      expect(filter1, isNot(equals(filter3)));
    });
  });
}
