import 'package:flutter_test/flutter_test.dart';
import 'package:json_getter/json_getter.dart';

void main() {
  group('Filters Class Tests', () {
    test('Can instantiate Filters with a list of Filter objects', () {
      const filter1 = Filter(
        selectorType: SelectorType.getValueByKey,
        filterBy: FilterBy.key,
        key: 'key1',
        operator: Operator.equal,
        value: 'value1',
      );
      const filter2 = Filter(
        selectorType: SelectorType.getValueAt,
        filterBy: FilterBy.value,
        key: 'key2',
        operator: Operator.notEqual,
        value: 'value2',
      );

      final filters = Filters(filters: [filter1, filter2]);

      expect(filters.filters.length, 2);
      expect(filters.filters[0], filter1);
      expect(filters.filters[1], filter2);
    });

    test('Filters can handle an empty list', () {
      final filters = Filters(filters: []);

      expect(filters.filters, isEmpty);
    });

    test('Filters allows adding a Filter to the list', () {
      final filters = Filters(filters: []);
      const newFilter = Filter(
        selectorType: SelectorType.getValueFirst,
        filterBy: FilterBy.value,
        key: 'key3',
        operator: Operator.contains,
        value: 'value3',
      );

      filters.filters.add(newFilter);

      expect(filters.filters.length, 1);
      expect(filters.filters[0], newFilter);
    });

    test('Filters equality and hashCode', () {
      const filter1 = Filter(
        selectorType: SelectorType.getValueByKey,
        filterBy: FilterBy.key,
        key: 'key1',
        operator: Operator.equal,
        value: 'value1',
      );

      const filter2 = Filter(
        selectorType: SelectorType.getValueAt,
        filterBy: FilterBy.value,
        key: 'key2',
        operator: Operator.notEqual,
        value: 'value2',
      );

      final filters1 = Filters(filters: [filter1, filter2]);
      final filters2 = Filters(filters: [filter1, filter2]);
      final filters3 = Filters(filters: [filter2]);

      expect(filters1, equals(filters2));
      expect(filters1.hashCode, equals(filters2.hashCode));
      expect(filters1, isNot(equals(filters3)));
    });
  });
}
