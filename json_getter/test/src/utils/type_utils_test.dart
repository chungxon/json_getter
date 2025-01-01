import 'package:flutter_test/flutter_test.dart';
import 'package:json_getter/json_getter.dart';

void main() {
  group('TypeUtils Class Tests', () {
    group('isJson', () {
      test('returns true for valid JSON object', () {
        const jsonString = '{"key": "value"}';
        expect(TypeUtils.isJson(jsonString), isTrue);
      });

      test('returns true for valid JSON array', () {
        const jsonString = '["value1", "value2"]';
        expect(TypeUtils.isJson(jsonString), isTrue);
      });

      test('returns false for invalid JSON string', () {
        const jsonString = 'invalid json';
        expect(TypeUtils.isJson(jsonString), isFalse);
      });

      test('returns false for non-JSON string', () {
        const jsonString = 'Just a string';
        expect(TypeUtils.isJson(jsonString), isFalse);
      });

      test('returns true for Map input', () {
        final json = {'key': 'value'};
        expect(TypeUtils.isJson(json), isTrue);
      });

      test('returns true for List input', () {
        final json = ['value1', 'value2'];
        expect(TypeUtils.isJson(json), isTrue);
      });

      test('returns false for non-JSON data type', () {
        const json = 12345;
        expect(TypeUtils.isJson(json), isFalse);
      });
    });

    group('isNotEmptyJson', () {
      test('returns true for non-empty JSON object', () {
        const jsonString = '{"key": "value"}';
        expect(TypeUtils.isNotEmptyJson(jsonString), isTrue);
      });

      test('returns true for non-empty JSON array', () {
        const jsonString = '["value1", "value2"]';
        expect(TypeUtils.isNotEmptyJson(jsonString), isTrue);
      });

      test('returns false for empty JSON object', () {
        const jsonString = '{}';
        expect(TypeUtils.isNotEmptyJson(jsonString), isFalse);
      });

      test('returns false for empty JSON array', () {
        const jsonString = '[]';
        expect(TypeUtils.isNotEmptyJson(jsonString), isFalse);
      });

      test('returns false for invalid JSON string', () {
        const jsonString = 'invalid json';
        expect(TypeUtils.isNotEmptyJson(jsonString), isFalse);
      });

      test('returns false for non-JSON string', () {
        const jsonString = 'Just a string';
        expect(TypeUtils.isNotEmptyJson(jsonString), isFalse);
      });

      test('returns false for null input', () {
        expect(TypeUtils.isNotEmptyJson(null), isFalse);
      });

      test('returns true for non-empty Map input', () {
        final json = {'key': 'value'};
        expect(TypeUtils.isNotEmptyJson(json), isTrue);
      });

      test('returns true for non-empty List input', () {
        final json = ['value1', 'value2'];
        expect(TypeUtils.isNotEmptyJson(json), isTrue);
      });

      test('returns false for empty Map input', () {
        final json = {};
        expect(TypeUtils.isNotEmptyJson(json), isFalse);
      });

      test('returns false for empty List input', () {
        final json = [];
        expect(TypeUtils.isNotEmptyJson(json), isFalse);
      });
    });

    group('tryParseJson', () {
      test('parseJson correctly parses valid JSON', () {
        const jsonString = '{"key": "value"}';
        final result = TypeUtils.tryParseJson(jsonString);
        expect(result, isA<Map>());
        expect((result as Map)['key'], 'value');
      });

      test('parseJson returns null for invalid JSON', () {
        const invalidJsonString = '{key: value}';
        final result = TypeUtils.tryParseJson(invalidJsonString);
        expect(result, isNull);
      });
    });

    test('isList identifies valid list of type T', () {
      final list = ['a', 'b', 'c'];

      expect(TypeUtils.isList<String>(list), isTrue);
      expect(TypeUtils.isList<int>(list), isFalse);
    });

    test('isMap identifies valid map of type T', () {
      final map = {'key1': 1, 'key2': 2};

      expect(TypeUtils.isMap<int>(map), isTrue);
      expect(TypeUtils.isMap<String>(map), isFalse);
    });

    group('joinList', () {
      test('joinList concatenates list elements with separator', () {
        final list = ['a', 'b', 'c'];

        expect(TypeUtils.joinList(list, '-'), 'a-b-c');
        expect(TypeUtils.joinList(list, null), 'abc');
      });

      test('joinList returns empty string for non-list input', () {
        final json = {'key1': 'value1', 'key2': 'value2'};

        expect(TypeUtils.joinList(json, '-'), '');
      });
    });
  });
}
