import 'package:flutter_test/flutter_test.dart';
import 'package:json_getter/json_getter.dart';

void main() {
  group('SelectorType Enum Tests', () {
    test('SelectorType.title returns correct titles', () {
      expect(SelectorType.getValueByKey.title, 'Get Value By Key');
      expect(SelectorType.getAllKeys.title, 'Get All Keys');
      expect(SelectorType.getAllValues.title, 'Get All Values');
      expect(SelectorType.getLength.title, 'Get Length');
      expect(SelectorType.getValueFromWhere.title, 'Get Value From Where');
      expect(SelectorType.getValueAt.title, 'Get Value At');
      expect(SelectorType.getValueFirst.title, 'Get Value First');
      expect(SelectorType.getValueLast.title, 'Get Value Last');
      expect(SelectorType.join.title, 'Join');
      expect(SelectorType.getItemsFromWhere.title, 'Get Items From Where');
    });

    group('getSupportSelectorTypes method tests', () {
      test('Returns correct types for a list of strings', () {
        final json = ['a', 'b', 'c'];
        final supportedTypes = SelectorType.getSupportSelectorTypes(json);
        expect(
          supportedTypes,
          containsAll([
            SelectorType.getLength,
            SelectorType.getValueAt,
            SelectorType.getValueFirst,
            SelectorType.getValueLast,
            SelectorType.getValueFromWhere,
            SelectorType.join,
          ]),
        );
      });

      test('Returns correct types for a generic list', () {
        final json = [1, 2, 3];
        final supportedTypes = SelectorType.getSupportSelectorTypes(json);
        expect(
          supportedTypes,
          containsAll([
            SelectorType.getLength,
            SelectorType.getValueAt,
            SelectorType.getValueFirst,
            SelectorType.getValueLast,
            SelectorType.getValueFromWhere,
          ]),
        );
      });

      test('Returns correct types for a map', () {
        final json = {'key1': 'value1', 'key2': 'value2'};
        final supportedTypes = SelectorType.getSupportSelectorTypes(json);
        expect(
          supportedTypes,
          containsAll([
            SelectorType.getValueByKey,
            SelectorType.getAllKeys,
            SelectorType.getAllValues,
            SelectorType.getLength,
            SelectorType.getValueFromWhere,
          ]),
        );
      });

      test('Returns empty list for unsupported types', () {
        const json = 12345; // Unsupported type
        final supportedTypes = SelectorType.getSupportSelectorTypes(json);
        expect(supportedTypes, isEmpty);
      });
    });
  });
}
