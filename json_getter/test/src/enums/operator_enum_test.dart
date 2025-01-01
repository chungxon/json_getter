import 'package:flutter_test/flutter_test.dart';
import 'package:json_getter/json_getter.dart';

void main() {
  group('Operator Enum Tests', () {
    test('Operator.title returns correct titles', () {
      expect(Operator.equal.title, 'Equal');
      expect(Operator.notEqual.title, 'Not Equal');
      expect(Operator.contains.title, 'Contains');
      expect(Operator.notContains.title, 'Not Contains');
      expect(Operator.startsWith.title, 'Starts With');
      expect(Operator.notStartsWith.title, 'Not Starts With');
      expect(Operator.endsWith.title, 'Ends With');
      expect(Operator.notEndsWith.title, 'Not Ends With');
      expect(Operator.isEmpty.title, 'Is Empty');
      expect(Operator.isNotEmpty.title, 'Is Not Empty');
      expect(Operator.greaterThan.title, 'Greater Than');
      expect(Operator.greaterThanOrEqual.title, 'Greater Than Or Equal');
      expect(Operator.lessThan.title, 'Less Than');
      expect(Operator.lessThanOrEqual.title, 'Less Than Or Equal');
    });

    group('getSupportOperators method tests', () {
      test('Returns correct operators for String data type', () {
        final operators = Operator.getSupportOperators('test', FilterBy.value);
        expect(
          operators,
          containsAll([
            Operator.equal,
            Operator.notEqual,
            Operator.contains,
            Operator.notContains,
            Operator.startsWith,
            Operator.notStartsWith,
            Operator.endsWith,
            Operator.notEndsWith,
            Operator.isEmpty,
            Operator.isNotEmpty,
          ]),
        );
      });

      test('Returns correct operators for numeric data type', () {
        final operators = Operator.getSupportOperators(123, FilterBy.value);
        expect(
          operators,
          containsAll([
            Operator.equal,
            Operator.notEqual,
            Operator.greaterThan,
            Operator.greaterThanOrEqual,
            Operator.lessThan,
            Operator.lessThanOrEqual,
            Operator.isEmpty,
            Operator.isNotEmpty,
          ]),
        );
      });

      test('Returns correct operators for boolean data type', () {
        final operators = Operator.getSupportOperators(true, FilterBy.value);
        expect(
          operators,
          containsAll([
            Operator.equal,
            Operator.notEqual,
          ]),
        );
      });

      test('Returns correct operators for a List of strings', () {
        final operators =
            Operator.getSupportOperators(['a', 'b'], FilterBy.value);
        expect(
          operators,
          containsAll([
            Operator.equal,
            Operator.notEqual,
            Operator.contains,
            Operator.notContains,
            Operator.isEmpty,
            Operator.isNotEmpty,
          ]),
        );
      });

      test('Returns correct operators for a List of Maps', () {
        final operators = Operator.getSupportOperators(
          [
            {'key': 'value'},
            {'key': 'value'},
          ],
          FilterBy.value,
        );
        expect(
          operators,
          containsAll([
            Operator.isEmpty,
            Operator.isNotEmpty,
          ]),
        );
      });

      test('Returns correct operators for a Map', () {
        final operators =
            Operator.getSupportOperators({'key': 'value'}, FilterBy.value);
        expect(
          operators,
          containsAll([
            Operator.isEmpty,
            Operator.isNotEmpty,
          ]),
        );
      });

      test('Returns all operators for unsupported data types', () {
        final operators =
            Operator.getSupportOperators(null, null); // Unsupported type
        expect(operators, containsAll(Operator.values));
      });
    });
  });
}
