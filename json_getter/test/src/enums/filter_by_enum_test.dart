import 'package:flutter_test/flutter_test.dart';
import 'package:json_getter/json_getter.dart';

void main() {
  group('FilterBy Enum Tests', () {
    test('FilterBy.key should have isByKey true and isByValue false', () {
      const filterBy = FilterBy.key;

      expect(filterBy.isByKey, isTrue);
      expect(filterBy.isByValue, isFalse);
    });

    test('FilterBy.value should have isByValue true and isByKey false', () {
      const filterBy = FilterBy.value;

      expect(filterBy.isByValue, isTrue);
      expect(filterBy.isByKey, isFalse);
    });
  });
}
