import 'package:flutter_test/flutter_test.dart';
import 'package:json_getter/json_getter.dart';

void main() {
  group('DataType Enum Tests', () {
    test('Test string value return string type', () {
      expect(DataType.getType(''), DataType.string);
    });
    test('Test number value return number type', () {
      expect(DataType.getType(0), DataType.number);
    });
    test('Test boolean value return boolean type', () {
      expect(DataType.getType(true), DataType.boolean);
    });
    test('Test list value return list type', () {
      expect(DataType.getType([]), DataType.list);
    });
    test('Test map value return map type', () {
      expect(DataType.getType({}), DataType.map);
    });
    test('Test nullable value return nullable type', () {
      expect(DataType.getType(null), DataType.nullable);
    });
  });
}
