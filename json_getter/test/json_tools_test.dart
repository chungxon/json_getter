import 'package:flutter_test/flutter_test.dart';
import 'package:json_getter/json_getter.dart';

void main() {
  group('getAllKeys', () {
    test('getAllKeys returns keys from a Map', () {
      final json = {'key1': 'value1', 'key2': 'value2'};
      final keys = JsonTools.getAllKeys(json);
      expect(keys, equals(['key1', 'key2']));
    });

    test('getAllKeys returns unique keys from a List', () {
      final json = [
        {'key1': 'value1'},
        {'key2': 'value2'},
        {'key1': 'value3'},
      ];
      final keys = JsonTools.getAllKeys(json);
      expect(keys, equals(['key1', 'key2']));
    });

    test('getAllKeys returns unique keys from a String', () {
      const json = 'value';
      final keys = JsonTools.getAllKeys(json);
      expect(keys, equals(['value']));
    });

    test('getAllKeys returns unique keys from a null', () {
      const json = null;
      final keys = JsonTools.getAllKeys(json);
      expect(keys, equals([]));
    });

    test('getAllKeys handles a nested structure of Maps and Lists', () {
      final json = {
        'key1': {
          'nestedKey1': 'value1',
          'nestedKey2': {'deepKey': 'value2'},
        },
        'key2': [
          {'arrayKey1': 'value3'},
          {'arrayKey2': 'value4'},
        ],
      };
      final keys = JsonTools.getAllKeys(json);
      expect(
        keys,
        containsAll([
          'key1',
          'key2',
        ]),
      );
    });

    test('getAllKeys handles an empty Map', () {
      final json = {};
      final keys = JsonTools.getAllKeys(json);
      expect(keys, equals([]));
    });

    test('getAllKeys handles an empty List', () {
      final json = [];
      final keys = JsonTools.getAllKeys(json);
      expect(keys, equals([]));
    });
  });

  group('getAllValues', () {
    test('getAllValues returns values from a Map', () {
      final json = {'key1': 'value1', 'key2': 'value2'};
      final values = JsonTools.getAllValues(json);
      expect(values, equals(['value1', 'value2']));
    });

    test('getAllValues returns values from a List', () {
      final json = [
        {'key1': 'value1'},
        {'key2': 'value2'},
        {'key1': 'value3'},
      ];
      final values = JsonTools.getAllValues(json);
      expect(
        values,
        equals([
          'value1',
          'value2',
          'value3',
        ]),
      );
    });

    test('getAllValues returns values from a String', () {
      const json = 'value';
      final values = JsonTools.getAllValues(json);
      expect(values, equals(['value']));
    });

    test('getAllValues returns empty list from null', () {
      const json = null;
      final values = JsonTools.getAllValues(json);
      expect(values, equals([]));
    });

    test('getAllValues handles a nested structure of Maps and Lists', () {
      final json = {
        'key1': {
          'nestedKey1': 'value1',
          'nestedKey2': {'deepKey': 'value2'},
        },
        'key2': [
          {'arrayKey1': 'value3'},
          {'arrayKey2': 'value4'},
        ],
      };
      final values = JsonTools.getAllValues(json);
      expect(
        values,
        containsAll([
          {
            'nestedKey1': 'value1',
            'nestedKey2': {'deepKey': 'value2'},
          },
          [
            {'arrayKey1': 'value3'},
            {'arrayKey2': 'value4'},
          ]
        ]),
      );
    });

    test('getAllValues handles an empty Map', () {
      final json = {};
      final values = JsonTools.getAllValues(json);
      expect(values, equals([]));
    });

    test('getAllValues handles an empty List', () {
      final json = [];
      final values = JsonTools.getAllValues(json);
      expect(values, equals([]));
    });
  });

  group('getLength', () {
    test('getLength returns correct length for List', () {
      final json = [1, 2, 3];
      expect(JsonTools.getLength(json), 3);
    });

    test('getLength returns correct length for Map', () {
      final json = {'key1': 'value1', 'key2': 'value2'};
      expect(JsonTools.getLength(json), 2);
    });

    test('getLength returns correct length for String', () {
      const json = 'value';
      expect(JsonTools.getLength(json), 5);
    });

    test('getLength returns 0 for null', () {
      const json = null;
      expect(JsonTools.getLength(json), 0);
    });

    test('getLength returns 0 for non-iterable types', () {
      const json = 123;
      expect(JsonTools.getLength(json), 0);
    });
  });

  group('getValueByKey', () {
    test('getValueByKey returns value from List by key', () {
      final json = [
        {'key1': 'value1'},
        {'key2': 'value2'},
        {'key1': 'value3'},
      ];
      final result = JsonTools.getValueByKey(json, 'key1');
      expect(result, ['value1', 'value3']);
    });

    test('getValueByKey returns null if key not found', () {
      final json = {'key1': 'value1'};
      final result = JsonTools.getValueByKey(json, 'key2');
      expect(result, isNull);
    });

    test('getValueByKey returns null if key is empty', () {
      final json = {'key1': 'value1'};
      final result = JsonTools.getValueByKey(json, '');
      expect(result, isNull);
    });

    test('getValueByKey returns value from Map by key', () {
      final json = {'key1': 'value1'};
      final result = JsonTools.getValueByKey(json, 'key1');
      expect(result, 'value1');
    });

    test('getValueByKey returns null if Map key is null', () {
      final json = {'key1': 'value1'};
      final result = JsonTools.getValueByKey(json, null);
      expect(result, isNull);
    });

    test('getValueByKey returns null for non-iterable types', () {
      const json = 123;
      final result = JsonTools.getValueByKey(json, 'key');
      expect(result, isNull);
    });
  });

  group('getValueAt', () {
    test('getValueAt returns value at index in List', () {
      final json = [1, 2, 3];
      final result = JsonTools.getValueAt(json, 1);
      expect(result, 2);
    });

    test('getValueAt returns null if index is out of bounds', () {
      final json = [1, 2, 3];
      final result = JsonTools.getValueAt(json, 5);
      expect(result, isNull);
    });

    test('getValueAt returns null if index is negative', () {
      final json = [1, 2, 3];
      final result = JsonTools.getValueAt(json, -1);
      expect(result, isNull);
    });

    test('getValueAt returns value if index is able to be parsed as integer',
        () {
      final json = [1, 2, 3];
      final result = JsonTools.getValueAt(json, '1');
      expect(result, 2);
    });

    test('getValueAt returns null if index is not an integer', () {
      final json = [1, 2, 3];
      final result = JsonTools.getValueAt(json, 'one');
      expect(result, isNull);
    });
  });

  group('getValueFirst', () {
    test('getValueFirst returns null for empty list', () {
      final json = [];
      final result = JsonTools.getValueFirst(json);
      expect(result, isNull);
    });

    test('getValueLast returns null for empty list', () {
      final json = [];
      final result = JsonTools.getValueLast(json);
      expect(result, isNull);
    });
  });

  group('getValueLast', () {
    test('getValueLast returns last value from List', () {
      final json = [1, 2, 3];
      final result = JsonTools.getValueLast(json);
      expect(result, 3);
    });

    test('getValueLast returns null for empty list', () {
      final json = [];
      final result = JsonTools.getValueLast(json);
      expect(result, isNull);
    });
  });

  group('getValueFromWhere', () {
    group('getValueFromWhereByValue', () {
      group('getValueFromWhereString', () {
        test('getValueFromWhere works with equal operator for String', () {
          const filter = Filter(
            selectorType: SelectorType.getValueFromWhere,
            filterBy: FilterBy.value,
            key: 'key1',
            operator: Operator.equal,
            value: 'value',
          );
          final json = {'key1': 'value'};
          final result = JsonTools.getValueFromWhere(json, filter);
          expect(result, 'value');
        });

        test('getValueFromWhere works with notEqual operator for String', () {
          const filter = Filter(
            selectorType: SelectorType.getValueFromWhere,
            filterBy: FilterBy.value,
            key: 'key1',
            operator: Operator.notEqual,
            value: 'value',
          );
          final json = {'key1': 'other'};
          final result = JsonTools.getValueFromWhere(json, filter);
          expect(result, 'other');
        });

        test('getValueFromWhere works with contains operator for String', () {
          const filter = Filter(
            selectorType: SelectorType.getValueFromWhere,
            filterBy: FilterBy.value,
            key: 'key1',
            operator: Operator.contains,
            value: 'value',
          );
          final json = {'key1': 'this is a value'};
          final result = JsonTools.getValueFromWhere(json, filter);
          expect(result, 'this is a value');
        });

        test('getValueFromWhere works with notContains operator for String',
            () {
          const filter = Filter(
            selectorType: SelectorType.getValueFromWhere,
            filterBy: FilterBy.value,
            key: 'key1',
            operator: Operator.notContains,
            value: 'value',
          );
          final json = {'key1': 'no match here'};
          final result = JsonTools.getValueFromWhere(json, filter);
          expect(result, 'no match here');
        });

        test('getValueFromWhere works with startsWith operator for String', () {
          const filter = Filter(
            selectorType: SelectorType.getValueFromWhere,
            filterBy: FilterBy.value,
            key: 'key1',
            operator: Operator.startsWith,
            value: 'this',
          );
          final json = {'key1': 'this is a test'};
          final result = JsonTools.getValueFromWhere(json, filter);
          expect(result, 'this is a test');
        });

        test('getValueFromWhere works with notStartsWith operator for String',
            () {
          const filter = Filter(
            selectorType: SelectorType.getValueFromWhere,
            filterBy: FilterBy.value,
            key: 'key1',
            operator: Operator.notStartsWith,
            value: 'this',
          );
          const json = 'this is a test';
          final result = JsonTools.getValueFromWhere(json, filter);
          expect(result, isNull);
        });

        test('getValueFromWhere works with endsWith operator for String', () {
          const filter = Filter(
            selectorType: SelectorType.getValueFromWhere,
            filterBy: FilterBy.value,
            key: 'key1',
            operator: Operator.endsWith,
            value: 'test',
          );
          final json = {'key1': 'this is a test'};
          final result = JsonTools.getValueFromWhere(json, filter);
          expect(result, 'this is a test');
        });

        test('getValueFromWhere works with notEndsWith operator for String',
            () {
          const filter = Filter(
            selectorType: SelectorType.getValueFromWhere,
            filterBy: FilterBy.value,
            key: 'key1',
            operator: Operator.notEndsWith,
            value: 'test',
          );
          const json = 'this is a test';
          final result = JsonTools.getValueFromWhere(json, filter);
          expect(result, isNull);
        });

        test('getValueFromWhere works with isEmpty operator for String', () {
          const filter = Filter(
            selectorType: SelectorType.getValueFromWhere,
            filterBy: FilterBy.value,
            key: 'key1',
            operator: Operator.isEmpty,
            value: '',
          );
          final json = {'key1': ''};
          final result = JsonTools.getValueFromWhere(json, filter);
          expect(result, '');
        });

        test('getValueFromWhere works with isNotEmpty operator for String', () {
          const filter = Filter(
            selectorType: SelectorType.getValueFromWhere,
            filterBy: FilterBy.value,
            key: 'key1',
            operator: Operator.isNotEmpty,
            value: '',
          );
          final json = {'key1': 'value'};
          final result = JsonTools.getValueFromWhere(json, filter);
          expect(result, 'value');
        });

        test('getValueFromWhere returns null for unmatched operator condition',
            () {
          const filter = Filter(
            selectorType: SelectorType.getValueFromWhere,
            filterBy: FilterBy.value,
            key: 'key1',
            operator: Operator.equal,
            value: 'wrongValue',
          );
          final json = {'key1': 'value'};
          final result = JsonTools.getValueFromWhere(json, filter);
          expect(result, isNull);
        });
      });

      group('getValueFromWhereNumber', () {
        test('getValueFromWhere works with equal operator for Number', () {
          const filter = Filter(
            selectorType: SelectorType.getValueFromWhere,
            filterBy: FilterBy.value,
            key: 'key1',
            operator: Operator.equal,
            value: 5,
          );
          final json = {'key1': 5};
          final result = JsonTools.getValueFromWhere(json, filter);
          expect(result, 5);
        });

        test('getValueFromWhere works with notEqual operator for Number', () {
          const filter = Filter(
            selectorType: SelectorType.getValueFromWhere,
            filterBy: FilterBy.value,
            key: 'key1',
            operator: Operator.notEqual,
            value: 10,
          );
          final json = {'key1': 5};
          final result = JsonTools.getValueFromWhere(json, filter);
          expect(result, 5);
        });

        test('getValueFromWhere works with greaterThan operator for Number',
            () {
          const filter = Filter(
            selectorType: SelectorType.getValueFromWhere,
            filterBy: FilterBy.value,
            key: 'key1',
            operator: Operator.greaterThan,
            value: 3,
          );
          final json = {'key1': 5};
          final result = JsonTools.getValueFromWhere(json, filter);
          expect(result, 5);
        });

        test(
            'getValueFromWhere works with greaterThanOrEqual operator for Number',
            () {
          const filter = Filter(
            selectorType: SelectorType.getValueFromWhere,
            filterBy: FilterBy.value,
            key: 'key1',
            operator: Operator.greaterThanOrEqual,
            value: 5,
          );
          final json = {'key1': 5};
          final result = JsonTools.getValueFromWhere(json, filter);
          expect(result, 5);
        });

        test('getValueFromWhere works with lessThan operator for Number', () {
          const filter = Filter(
            selectorType: SelectorType.getValueFromWhere,
            filterBy: FilterBy.value,
            key: 'key1',
            operator: Operator.lessThan,
            value: 10,
          );
          final json = {'key1': 5};
          final result = JsonTools.getValueFromWhere(json, filter);
          expect(result, 5);
        });

        test('getValueFromWhere works with lessThanOrEqual operator for Number',
            () {
          const filter = Filter(
            selectorType: SelectorType.getValueFromWhere,
            filterBy: FilterBy.value,
            key: 'key1',
            operator: Operator.lessThanOrEqual,
            value: 5,
          );
          final json = {'key1': 5};
          final result = JsonTools.getValueFromWhere(json, filter);
          expect(result, 5);
        });

        test('getValueFromWhere works with isEmpty operator for Number', () {
          const filter = Filter(
            selectorType: SelectorType.getValueFromWhere,
            filterBy: FilterBy.value,
            key: 'key1',
            operator: Operator.isEmpty,
            value: '',
          );
          final json = {'key1': 5};
          final result = JsonTools.getValueFromWhere(json, filter);
          expect(result, isNull);
        });

        test('getValueFromWhere works with isNotEmpty operator for Number', () {
          const filter = Filter(
            selectorType: SelectorType.getValueFromWhere,
            filterBy: FilterBy.value,
            key: 'key1',
            operator: Operator.isNotEmpty,
            value: '',
          );
          final json = {'key1': 5};
          final result = JsonTools.getValueFromWhere(json, filter);
          expect(result, 5);
        });

        test(
            'getValueFromWhere returns null for unmatched operator condition with Number',
            () {
          const filter = Filter(
            selectorType: SelectorType.getValueFromWhere,
            filterBy: FilterBy.value,
            key: 'key1',
            operator: Operator.equal,
            value: 10,
          );
          final json = {'key1': 5};
          final result = JsonTools.getValueFromWhere(json, filter);
          expect(result, isNull);
        });
      });

      group('getValueFromWhereBoolean', () {
        test('getValueFromWhere works with equal operator for Boolean', () {
          const filter = Filter(
            selectorType: SelectorType.getValueFromWhere,
            filterBy: FilterBy.value,
            key: 'key1',
            operator: Operator.equal,
            value: true,
          );
          final json = {'key1': true};
          final result = JsonTools.getValueFromWhere(json, filter);
          expect(result, true);
        });

        test('getValueFromWhere works with notEqual operator for Boolean', () {
          const filter = Filter(
            selectorType: SelectorType.getValueFromWhere,
            filterBy: FilterBy.value,
            key: 'key1',
            operator: Operator.notEqual,
            value: false,
          );
          final json = {'key1': true};
          final result = JsonTools.getValueFromWhere(json, filter);
          expect(result, true);
        });

        test('getValueFromWhere returns null for invalid operator with Boolean',
            () {
          const filter = Filter(
            selectorType: SelectorType.getValueFromWhere,
            filterBy: FilterBy.value,
            key: 'key1',
            operator: Operator.contains,
            value: true,
          );
          final json = {'key1': true};
          final result = JsonTools.getValueFromWhere(json, filter);
          expect(result, isNull);
        });

        test(
            'getValueFromWhere returns null for mismatched Boolean value with equal operator',
            () {
          const filter = Filter(
            selectorType: SelectorType.getValueFromWhere,
            filterBy: FilterBy.value,
            key: 'key1',
            operator: Operator.equal,
            value: false,
          );
          final json = {'key1': true};
          final result = JsonTools.getValueFromWhere(json, filter);
          expect(result, isNull);
        });
      });

      group('getValueFromWhereList', () {
        test('getValueFromWhere works with equal operator for List', () {
          const filter = Filter(
            selectorType: SelectorType.getValueFromWhere,
            filterBy: FilterBy.value,
            key: 'key1',
            operator: Operator.equal,
            value: 'value1',
          );
          final json = {
            'key1': ['value1', 'value2'],
          };
          final result = JsonTools.getValueFromWhere(json, filter);
          expect(result, ['value1']);
        });

        test('getValueFromWhere works with notEqual operator for List', () {
          const filter = Filter(
            selectorType: SelectorType.getValueFromWhere,
            filterBy: FilterBy.value,
            key: 'key1',
            operator: Operator.notEqual,
            value: 'value2',
          );
          final json = {
            'key1': ['value1', 'value2'],
          };
          final result = JsonTools.getValueFromWhere(json, filter);
          expect(result, ['value1']);
        });

        test('getValueFromWhere works with contains operator for List', () {
          const filter = Filter(
            selectorType: SelectorType.getValueFromWhere,
            filterBy: FilterBy.value,
            key: 'key1',
            operator: Operator.contains,
            value: 'value1',
          );
          final json = {
            'key1': ['value1', 'value2'],
          };
          final result = JsonTools.getValueFromWhere(json, filter);
          expect(result, ['value1']);
        });

        test('getValueFromWhere works with notContains operator for List', () {
          const filter = Filter(
            selectorType: SelectorType.getValueFromWhere,
            filterBy: FilterBy.value,
            key: 'key1',
            operator: Operator.notContains,
            value: 'value3',
          );
          final json = {
            'key1': ['value1', 'value2'],
          };
          final result = JsonTools.getValueFromWhere(json, filter);
          expect(result, ['value1', 'value2']);
        });

        test('getValueFromWhere works with startsWith operator for List', () {
          const filter = Filter(
            selectorType: SelectorType.getValueFromWhere,
            filterBy: FilterBy.value,
            key: 'key1',
            operator: Operator.startsWith,
            value: 'value1',
          );
          final json = {
            'key1': ['value1', 'value2'],
          };
          final result = JsonTools.getValueFromWhere(json, filter);
          expect(result, ['value1']);
        });

        test('getValueFromWhere works with notStartsWith operator for List',
            () {
          const filter = Filter(
            selectorType: SelectorType.getValueFromWhere,
            filterBy: FilterBy.value,
            key: 'key1',
            operator: Operator.notStartsWith,
            value: 'value3',
          );
          final json = {
            'key1': ['value1', 'value2'],
          };
          final result = JsonTools.getValueFromWhere(json, filter);
          expect(result, ['value1', 'value2']);
        });

        test('getValueFromWhere works with endsWith operator for List', () {
          const filter = Filter(
            selectorType: SelectorType.getValueFromWhere,
            filterBy: FilterBy.value,
            key: 'key1',
            operator: Operator.endsWith,
            value: 'value2',
          );
          final json = {
            'key1': ['value1', 'value2'],
          };
          final result = JsonTools.getValueFromWhere(json, filter);
          expect(result, ['value2']);
        });

        test('getValueFromWhere works with notEndsWith operator for List', () {
          const filter = Filter(
            selectorType: SelectorType.getValueFromWhere,
            filterBy: FilterBy.value,
            key: 'key1',
            operator: Operator.notEndsWith,
            value: 'value3',
          );
          final json = {
            'key1': ['value1', 'value2'],
          };
          final result = JsonTools.getValueFromWhere(json, filter);
          expect(result, ['value1', 'value2']);
        });

        test('getValueFromWhere works with isEmpty operator for List', () {
          const filter = Filter(
            selectorType: SelectorType.getValueFromWhere,
            filterBy: FilterBy.value,
            key: 'key1',
            operator: Operator.isEmpty,
            value: '',
          );
          final json = {'key1': []};
          final result = JsonTools.getValueFromWhere(json, filter);
          expect(result, []);
        });

        test('getValueFromWhere works with isNotEmpty operator for List', () {
          const filter = Filter(
            selectorType: SelectorType.getValueFromWhere,
            filterBy: FilterBy.value,
            key: 'key1',
            operator: Operator.isNotEmpty,
            value: '',
          );
          final json = {
            'key1': ['value1'],
          };
          final result = JsonTools.getValueFromWhere(json, filter);
          expect(result, ['value1']);
        });

        test('getValueFromWhere returns null for invalid operator with List',
            () {
          const filter = Filter(
            selectorType: SelectorType.getValueFromWhere,
            filterBy: FilterBy.value,
            key: 'key1',
            operator: Operator.greaterThan,
            value: 'value1',
          );
          final json = {
            'key1': ['value1', 'value2'],
          };
          final result = JsonTools.getValueFromWhere(json, filter);
          expect(result, isNull);
        });
      });

      group('getValueFromWhereMap', () {
        test('getValueFromWhere works with isEmpty operator for Map', () {
          const filter = Filter(
            selectorType: SelectorType.getValueFromWhere,
            filterBy: FilterBy.value,
            key: 'key1',
            operator: Operator.isEmpty,
            value: '',
          );
          final json = {'key1': {}};
          final result = JsonTools.getValueFromWhere(json, filter);
          expect(result, {});
        });

        test('getValueFromWhere works with isNotEmpty operator for Map', () {
          const filter = Filter(
            selectorType: SelectorType.getValueFromWhere,
            filterBy: FilterBy.value,
            key: 'key1',
            operator: Operator.isNotEmpty,
            value: '',
          );
          final json = {
            'key1': {'subkey': 'value'},
          };
          final result = JsonTools.getValueFromWhere(json, filter);
          expect(result, {'subkey': 'value'});
        });

        test('getValueFromWhere returns null for invalid operator with Map',
            () {
          const filter = Filter(
            selectorType: SelectorType.getValueFromWhere,
            filterBy: FilterBy.value,
            key: 'key1',
            operator: Operator.greaterThan,
            value: 'value1',
          );
          final json = {
            'key1': {'subkey': 'value'},
          };
          final result = JsonTools.getValueFromWhere(json, filter);
          expect(result, isNull);
        });

        test(
            'getValueFromWhere returns null for unsupported operators with Map',
            () {
          const filter = Filter(
            selectorType: SelectorType.getValueFromWhere,
            filterBy: FilterBy.value,
            key: 'key1',
            operator: Operator.contains,
            value: 'value1',
          );
          final json = {
            'key1': {'subkey': 'value'},
          };
          final result = JsonTools.getValueFromWhere(json, filter);
          expect(result, isNull);
        });
      });
    });

    group('getValueFromWhereByKey', () {
      test('getValueFromWhereByKey works with equal operator for Map', () {
        const filter = Filter(
          selectorType: SelectorType.getValueFromWhere,
          filterBy: FilterBy.key,
          key: 'key1',
          operator: Operator.equal,
        );
        final json = {'key1': 'value1', 'key2': 'value2'};
        final result = JsonTools.getValueFromWhere(json, filter);
        expect(result, 'value1');
      });

      test('getValueFromWhereByKey works with notEqual operator for Map', () {
        const filter = Filter(
          selectorType: SelectorType.getValueFromWhere,
          filterBy: FilterBy.key,
          key: 'key1',
          operator: Operator.notEqual,
        );
        final json = {'key1': 'value1', 'key2': 'value2'};
        final result = JsonTools.getValueFromWhere(json, filter);
        // Returns null as `notEqual` is not handled for Map
        expect(result, isNull);
      });

      test('getValueFromWhereByKey works with contains operator for Map', () {
        const filter = Filter(
          selectorType: SelectorType.getValueFromWhere,
          filterBy: FilterBy.key,
          key: 'key1',
          operator: Operator.contains,
        );
        final json = {'key1': 'value1', 'key2': 'value2'};
        final result = JsonTools.getValueFromWhere(json, filter);
        // Returns null as `contains` is not handled for Map
        expect(result, isNull);
      });

      test('getValueFromWhereByKey works with contains operator for List', () {
        const filter = Filter(
          selectorType: SelectorType.getValueFromWhere,
          filterBy: FilterBy.key,
          key: 'value',
          operator: Operator.contains,
        );
        final json = ['value1', 'value2'];
        final result = JsonTools.getValueFromWhere(json, filter);
        expect(result, ['value1', 'value2']);
      });

      test('getValueFromWhereByKey works with contains operator for String',
          () {
        const filter = Filter(
          selectorType: SelectorType.getValueFromWhere,
          filterBy: FilterBy.key,
          key: 'string',
          operator: Operator.contains,
        );
        const json = 'This is a string';
        final result = JsonTools.getValueFromWhere(json, filter);
        expect(result, 'This is a string');
      });

      test('getValueFromWhereByKey works with notContains operator for Map',
          () {
        const filter = Filter(
          selectorType: SelectorType.getValueFromWhere,
          filterBy: FilterBy.key,
          key: 'key1',
          operator: Operator.notContains,
        );
        final json = {'key1': 'value1', 'key2': 'value2'};
        final result = JsonTools.getValueFromWhere(json, filter);
        // Returns null as `notContains` is not handled for Map
        expect(result, isNull);
      });

      test('getValueFromWhereByKey works with notContains operator for List',
          () {
        const filter = Filter(
          selectorType: SelectorType.getValueFromWhere,
          filterBy: FilterBy.key,
          key: 'value',
          operator: Operator.notContains,
        );
        final json = ['value1', 'value2'];
        final result = JsonTools.getValueFromWhere(json, filter);
        expect(result, []);
      });

      test('getValueFromWhereByKey works with notContains operator for String',
          () {
        const filter = Filter(
          selectorType: SelectorType.getValueFromWhere,
          filterBy: FilterBy.key,
          key: 'string',
          operator: Operator.notContains,
        );
        const json = 'This is a string';
        final result = JsonTools.getValueFromWhere(json, filter);
        expect(result, isNull);
      });

      test('getValueFromWhereByKey works with equal operator for String', () {
        const filter = Filter(
          selectorType: SelectorType.getValueFromWhere,
          filterBy: FilterBy.key,
          key: 'key1',
          operator: Operator.equal,
        );
        const json = 'key1';
        final result = JsonTools.getValueFromWhere(json, filter);
        expect(result, 'key1');
      });

      test(
          'getValueFromWhereByKey returns null for invalid operator with String',
          () {
        const filter = Filter(
          selectorType: SelectorType.getValueFromWhere,
          filterBy: FilterBy.key,
          key: 'key1',
          operator: Operator.greaterThan,
        );
        const json = 'key1';
        final result = JsonTools.getValueFromWhere(json, filter);
        expect(result, isNull);
      });

      test('getValueFromWhereByKey works with equal operator for List', () {
        const filter = Filter(
          selectorType: SelectorType.getValueFromWhere,
          filterBy: FilterBy.key,
          key: 'key1',
          operator: Operator.equal,
        );
        final json = [
          {'key1': 'value1'},
          {'key2': 'value2'},
        ];
        final result = JsonTools.getValueFromWhere(json, filter);
        expect(result, ['value1']);
      });

      test('getValueFromWhereByKey works with notEqual operator for List', () {
        const filter = Filter(
          selectorType: SelectorType.getValueFromWhere,
          filterBy: FilterBy.key,
          key: 'value1',
          operator: Operator.notEqual,
        );
        final json = [
          'value1',
          'value2',
        ];
        final result = JsonTools.getValueFromWhere(json, filter);
        expect(result, ['value2']);
      });

      test('getValueFromWhereByKey returns null for invalid operator with List',
          () {
        const filter = Filter(
          selectorType: SelectorType.getValueFromWhere,
          filterBy: FilterBy.key,
          key: 'key1',
          operator: Operator.greaterThan,
        );
        final json = [
          {'key1': 'value1'},
          {'key2': 'value2'},
        ];
        final result = JsonTools.getValueFromWhere(json, filter);
        expect(result, isNull);
      });
    });
  });

  group('getItemsFromWhere', () {
    group('getItemsFromWhereByValueForList', () {
      test('getItemsFromWhere works with equal operator for List', () {
        const filter = Filter(
          selectorType: SelectorType.getItemsFromWhere,
          filterBy: FilterBy.value,
          key: 'key1',
          operator: Operator.equal,
          value: 'value1',
        );
        final json = [
          {'key1': 'value1', 'key2': 'value2'},
          {'key1': 'value3', 'key2': 'value4'},
          {'key1': 'value1', 'key2': 'value5'},
        ];
        final result = JsonTools.getItemsFromWhere(json, filter);
        expect(result, [
          {'key1': 'value1', 'key2': 'value2'},
          {'key1': 'value1', 'key2': 'value5'},
        ]);
      });

      test('getItemsFromWhere works with notEqual operator for List', () {
        const filter = Filter(
          selectorType: SelectorType.getItemsFromWhere,
          filterBy: FilterBy.value,
          key: 'key1',
          operator: Operator.notEqual,
          value: 'value1',
        );
        final json = [
          {'key1': 'value1', 'key2': 'value2'},
          {'key1': 'value3', 'key2': 'value4'},
          {'key1': 'value1', 'key2': 'value5'},
        ];
        final result = JsonTools.getItemsFromWhere(json, filter);
        expect(result, [
          {'key1': 'value3', 'key2': 'value4'},
        ]);
      });

      test('getItemsFromWhere works with contains operator for List', () {
        const filter = Filter(
          selectorType: SelectorType.getItemsFromWhere,
          filterBy: FilterBy.value,
          key: 'key1',
          operator: Operator.contains,
          value: 'value',
        );
        final json = [
          {'key1': 'value1', 'key2': 'value2'},
          {'key1': 'value3', 'key2': 'value4'},
          {'key1': 'value5', 'key2': 'value6'},
        ];
        final result = JsonTools.getItemsFromWhere(json, filter);
        expect(result, [
          {'key1': 'value1', 'key2': 'value2'},
          {'key1': 'value3', 'key2': 'value4'},
          {'key1': 'value5', 'key2': 'value6'},
        ]);
      });

      test('getItemsFromWhere works with notContains operator for List', () {
        const filter = Filter(
          selectorType: SelectorType.getItemsFromWhere,
          filterBy: FilterBy.value,
          key: 'key1',
          operator: Operator.notContains,
          value: 'value1',
        );
        final json = [
          {'key1': 'value1', 'key2': 'value2'},
          {'key1': 'value3', 'key2': 'value4'},
          {'key1': 'value5', 'key2': 'value6'},
        ];
        final result = JsonTools.getItemsFromWhere(json, filter);
        expect(result, [
          {'key1': 'value3', 'key2': 'value4'},
          {'key1': 'value5', 'key2': 'value6'},
        ]);
      });

      test('getItemsFromWhere works with string operator for List', () {
        const filter = Filter(
          selectorType: SelectorType.getItemsFromWhere,
          filterBy: FilterBy.value,
          key: 'key1',
          operator: Operator.equal,
          value: 'value1',
        );
        final json = [
          {'key1': 'value1', 'key2': 'value2'},
          {'key1': 'value2', 'key2': 'value3'},
        ];
        final result = JsonTools.getItemsFromWhere(json, filter);
        expect(result, [
          {'key1': 'value1', 'key2': 'value2'},
        ]);
      });

      test('getItemsFromWhere returns empty list for non-matching value', () {
        const filter = Filter(
          selectorType: SelectorType.getItemsFromWhere,
          filterBy: FilterBy.value,
          key: 'key1',
          operator: Operator.equal,
          value: 'valueX',
        );
        final json = [
          {'key1': 'value1', 'key2': 'value2'},
          {'key1': 'value2', 'key2': 'value3'},
        ];
        final result = JsonTools.getItemsFromWhere(json, filter);
        expect(result, []);
      });

      test('getItemsFromWhere works with number operator for List', () {
        const filter = Filter(
          selectorType: SelectorType.getItemsFromWhere,
          filterBy: FilterBy.value,
          key: 'key1',
          operator: Operator.equal,
          value: 5,
        );
        final json = [
          {'key1': 5, 'key2': 'value1'},
          {'key1': 10, 'key2': 'value2'},
          {'key1': 5, 'key2': 'value3'},
        ];
        final result = JsonTools.getItemsFromWhere(json, filter);
        expect(result, [
          {'key1': 5, 'key2': 'value1'},
          {'key1': 5, 'key2': 'value3'},
        ]);
      });

      test('getItemsFromWhere works with boolean operator for List', () {
        const filter = Filter(
          selectorType: SelectorType.getItemsFromWhere,
          filterBy: FilterBy.value,
          key: 'key1',
          operator: Operator.equal,
          value: true,
        );
        final json = [
          {'key1': true, 'key2': 'value1'},
          {'key1': 10, 'key2': 'value2'},
          {'key1': 5, 'key2': 'value3'},
        ];
        final result = JsonTools.getItemsFromWhere(json, filter);
        expect(result, [
          {'key1': true, 'key2': 'value1'},
        ]);
      });

      test('getItemsFromWhere works with map data for List', () {
        const filter = Filter(
          selectorType: SelectorType.getItemsFromWhere,
          filterBy: FilterBy.value,
          key: 'key1',
          operator: Operator.isNotEmpty,
          value: true,
        );
        final json = [
          {
            'key1': {'key1': true, 'key2': 'value1'},
            'key2': 'value1',
          },
          {'key1': 10, 'key2': 'value2'},
          {'key1': 5, 'key2': 'value3'},
        ];
        final result = JsonTools.getItemsFromWhere(json, filter);
        expect(result, [
          {
            'key1': {'key1': true, 'key2': 'value1'},
            'key2': 'value1',
          },
          {'key1': 10, 'key2': 'value2'},
          {'key1': 5, 'key2': 'value3'},
        ]);
      });

      test(
          'getItemsFromWhere works with notEqual operator for List with number',
          () {
        const filter = Filter(
          selectorType: SelectorType.getItemsFromWhere,
          filterBy: FilterBy.value,
          key: 'key1',
          operator: Operator.notEqual,
          value: 5,
        );
        final json = [
          {'key1': 5, 'key2': 'value1'},
          {'key1': 10, 'key2': 'value2'},
          {'key1': 15, 'key2': 'value3'},
        ];
        final result = JsonTools.getItemsFromWhere(json, filter);
        expect(result, [
          {'key1': 10, 'key2': 'value2'},
          {'key1': 15, 'key2': 'value3'},
        ]);
      });

      test(
          'getItemsFromWhere returns empty list if no match for number operator',
          () {
        const filter = Filter(
          selectorType: SelectorType.getItemsFromWhere,
          filterBy: FilterBy.value,
          key: 'key1',
          operator: Operator.equal,
          value: 100,
        );
        final json = [
          {'key1': 5, 'key2': 'value1'},
          {'key1': 10, 'key2': 'value2'},
        ];
        final result = JsonTools.getItemsFromWhere(json, filter);
        expect(result, []);
      });
    });

    group('getItemsFromWhereByValueForMap', () {
      test('getItemsFromWhere works with equal operator for Map', () {
        const filter = Filter(
          selectorType: SelectorType.getItemsFromWhere,
          filterBy: FilterBy.value,
          operator: Operator.equal,
          value: 'value1',
        );
        final json = {
          'key1': 'value1',
          'key2': 'value2',
          'key3': 'value1',
          'key4': 'value4',
        };
        final result = JsonTools.getItemsFromWhere(json, filter);
        expect(result, {
          'key1': 'value1',
          'key3': 'value1',
        });
      });

      test('getItemsFromWhere works with notEqual operator for Map', () {
        const filter = Filter(
          selectorType: SelectorType.getItemsFromWhere,
          filterBy: FilterBy.value,
          operator: Operator.notEqual,
          value: 'value1',
        );
        final json = {
          'key1': 'value1',
          'key2': 'value2',
          'key3': 'value1',
          'key4': 'value4',
        };
        final result = JsonTools.getItemsFromWhere(json, filter);
        expect(result, {
          'key2': 'value2',
          'key4': 'value4',
        });
      });

      test('getItemsFromWhere works with contains operator for Map', () {
        const filter = Filter(
          selectorType: SelectorType.getItemsFromWhere,
          filterBy: FilterBy.value,
          operator: Operator.contains,
          value: 'value',
        );
        final json = {
          'key1': 'value1',
          'key2': 'value2',
          'key3': 'value1',
          'key4': 'value4',
        };
        final result = JsonTools.getItemsFromWhere(json, filter);
        expect(result, {
          'key1': 'value1',
          'key2': 'value2',
          'key3': 'value1',
          'key4': 'value4',
        });
      });

      test('getItemsFromWhere works with notContains operator for Map', () {
        const filter = Filter(
          selectorType: SelectorType.getItemsFromWhere,
          filterBy: FilterBy.value,
          operator: Operator.notContains,
          value: 'value',
        );
        final json = {
          'key1': 'value1',
          'key2': 'value2',
          'key3': 'value1',
          'key4': 'value4',
        };
        final result = JsonTools.getItemsFromWhere(json, filter);
        expect(result, {});
      });

      test('getItemsFromWhere returns empty map for non-matching value in Map',
          () {
        const filter = Filter(
          selectorType: SelectorType.getItemsFromWhere,
          filterBy: FilterBy.value,
          key: 'key1',
          operator: Operator.equal,
          value: 'valueX',
        );
        final json = {
          'item1': {'key1': 'value1', 'key2': 'value2'},
          'item2': {'key1': 'value3', 'key2': 'value4'},
        };
        final result = JsonTools.getItemsFromWhere(json, filter);
        expect(result, {});
      });

      test('getItemsFromWhere works with number operator for Map', () {
        const filter = Filter(
          selectorType: SelectorType.getItemsFromWhere,
          filterBy: FilterBy.value,
          operator: Operator.equal,
          value: 5,
        );
        final json = {
          'key1': 5,
          'key3': 10,
        };
        final result = JsonTools.getItemsFromWhere(json, filter);
        expect(result, {'key1': 5});
      });

      test('getItemsFromWhere works with boolean operator for Map', () {
        const filter = Filter(
          selectorType: SelectorType.getItemsFromWhere,
          filterBy: FilterBy.value,
          operator: Operator.equal,
          value: true,
        );
        final json = {
          'key1': true,
          'key3': 10,
        };
        final result = JsonTools.getItemsFromWhere(json, filter);
        expect(result, {'key1': true});
      });

      test('getItemsFromWhere works with notEqual operator for Map with number',
          () {
        const filter = Filter(
          selectorType: SelectorType.getItemsFromWhere,
          filterBy: FilterBy.value,
          operator: Operator.notEqual,
          value: 5,
        );
        final json = {
          'key1': 5,
          'key3': 10,
        };
        final result = JsonTools.getItemsFromWhere(json, filter);
        expect(result, {'key3': 10});
      });

      test('getItemsFromWhere returns empty map for non-matching number in Map',
          () {
        const filter = Filter(
          selectorType: SelectorType.getItemsFromWhere,
          filterBy: FilterBy.value,
          operator: Operator.equal,
          value: 100,
        );
        final json = {
          'key1': 5,
          'key3': 10,
        };
        final result = JsonTools.getItemsFromWhere(json, filter);
        expect(result, {});
      });

      test('getItemsFromWhere works with List data in Map', () {
        const filter = Filter(
          selectorType: SelectorType.getItemsFromWhere,
          filterBy: FilterBy.value,
          key: 'key1',
          operator: Operator.equal,
        );
        final json = {
          'key1': ['key1', 'key2'],
          'key2': 'value1',
        };
        final result = JsonTools.getItemsFromWhere(json, filter);
        expect(result, {
          'key1': ['key1', 'key2'],
        });
      });

      test('getItemsFromWhere works with Map data in Map', () {
        const filter = Filter(
          selectorType: SelectorType.getItemsFromWhere,
          filterBy: FilterBy.value,
          key: 'key1',
          operator: Operator.isNotEmpty,
        );
        final json = {
          'key1': {
            'key3': 'value3',
            'key4': 'value4',
          },
          'key2': '',
        };
        final result = JsonTools.getItemsFromWhere(json, filter);
        expect(result, {
          'key1': {
            'key3': 'value3',
            'key4': 'value4',
          },
        });
      });
    });

    group('getItemsFromWhereByKey', () {
      test('Operator equal for Map', () {
        const filter = Filter(
          selectorType: SelectorType.getItemsFromWhere,
          filterBy: FilterBy.key,
          key: 'key1',
          operator: Operator.equal,
        );
        final json = {'key1': 'value1', 'key2': 'value2'};
        final result = JsonTools.getItemsFromWhere(json, filter);
        expect(result, {'key1': 'value1'});
      });

      test('Operator notEqual for Map', () {
        const filter = Filter(
          selectorType: SelectorType.getItemsFromWhere,
          filterBy: FilterBy.key,
          key: 'key1',
          operator: Operator.notEqual,
        );
        final json = {'key1': 'value2', 'key2': 'value1'};
        final result = JsonTools.getItemsFromWhere(json, filter);
        expect(result, {'key2': 'value1'});
      });

      test('Operator contains for Map', () {
        const filter = Filter(
          selectorType: SelectorType.getItemsFromWhere,
          filterBy: FilterBy.key,
          key: 'key1',
          operator: Operator.contains,
        );
        final json = {'key1': 'value1', 'key2': 'value2'};
        final result = JsonTools.getItemsFromWhere(json, filter);
        expect(result, {'key1': 'value1', 'key2': 'value2'});
      });

      test('Operator notContains for Map', () {
        const filter = Filter(
          selectorType: SelectorType.getItemsFromWhere,
          filterBy: FilterBy.key,
          key: 'key1',
          operator: Operator.notContains,
        );
        final json = {'key1': 'value1', 'key2': 'value2'};
        final result = JsonTools.getItemsFromWhere(json, filter);
        expect(result, {'key2': 'value2'});
      });

      test('Operator isEmpty for Map', () {
        const filter = Filter(
          selectorType: SelectorType.getItemsFromWhere,
          filterBy: FilterBy.key,
          key: 'key1',
          operator: Operator.isEmpty,
        );
        final json = {'key1': '', 'key2': 'value'};
        final result = JsonTools.getItemsFromWhere(json, filter);
        expect(result, isNull);
      });

      test('Operator isNotEmpty for Map', () {
        const filter = Filter(
          selectorType: SelectorType.getItemsFromWhere,
          filterBy: FilterBy.key,
          key: 'key1',
          operator: Operator.isNotEmpty,
        );
        final json = {'key1': 'value1', 'key2': ''};
        final result = JsonTools.getItemsFromWhere(json, filter);
        expect(result, isNull);
      });

      test('Operator equal for List', () {
        const filter = Filter(
          selectorType: SelectorType.getItemsFromWhere,
          filterBy: FilterBy.key,
          key: 'value1',
          operator: Operator.equal,
        );
        final json = [
          'value1',
          'value2',
          'value3',
          'value1',
        ];
        final result = JsonTools.getItemsFromWhere(json, filter);
        expect(result, [
          'value1',
          'value1',
        ]);
      });

      test('Operator notEqual for List', () {
        const filter = Filter(
          selectorType: SelectorType.getItemsFromWhere,
          filterBy: FilterBy.key,
          key: 'value1',
          operator: Operator.notEqual,
        );
        final json = [
          'value1',
          'value2',
          'value3',
          'value1',
        ];
        final result = JsonTools.getItemsFromWhere(json, filter);
        expect(result, [
          'value2',
          'value3',
        ]);
      });

      test('Operator contains for List', () {
        const filter = Filter(
          selectorType: SelectorType.getItemsFromWhere,
          filterBy: FilterBy.key,
          key: 'value',
          operator: Operator.contains,
        );
        final json = [
          'value1',
          'value2',
          'value3',
          'value1',
        ];
        final result = JsonTools.getItemsFromWhere(json, filter);
        expect(result, [
          'value1',
          'value2',
          'value3',
          'value1',
        ]);
      });

      test('Operator notContains for List', () {
        const filter = Filter(
          selectorType: SelectorType.getItemsFromWhere,
          filterBy: FilterBy.key,
          key: '1',
          operator: Operator.notContains,
        );
        final json = [
          'value1',
          'value2',
          'value3',
          'value1',
        ];
        final result = JsonTools.getItemsFromWhere(json, filter);
        expect(result, [
          'value2',
          'value3',
        ]);
      });

      test('Operator isEmpty for List', () {
        const filter = Filter(
          selectorType: SelectorType.getItemsFromWhere,
          filterBy: FilterBy.key,
          operator: Operator.isEmpty,
        );
        final json = [{}];
        final result = JsonTools.getItemsFromWhere(json, filter);
        expect(result, [{}]);
      });

      test('Operator isNotEmpty for List', () {
        const filter = Filter(
          selectorType: SelectorType.getItemsFromWhere,
          filterBy: FilterBy.key,
          operator: Operator.isNotEmpty,
        );
        final json = [
          {'key1': 'test1'},
        ];
        final result = JsonTools.getItemsFromWhere(json, filter);
        expect(result, [
          {'key1': 'test1'},
        ]);
      });

      test('Operator equal for String', () {
        const filter = Filter(
          selectorType: SelectorType.getItemsFromWhere,
          filterBy: FilterBy.key,
          key: 'key1',
          operator: Operator.equal,
        );
        const json = 'key1';
        final result = JsonTools.getItemsFromWhere(json, filter);
        expect(result, 'key1');
      });

      test('Operator notEqual for String', () {
        const filter = Filter(
          selectorType: SelectorType.getItemsFromWhere,
          filterBy: FilterBy.key,
          key: 'key1',
          operator: Operator.notEqual,
        );
        const json = 'key2';
        final result = JsonTools.getItemsFromWhere(json, filter);
        expect(result, 'key2');
      });

      test('Operator contains for String', () {
        const filter = Filter(
          selectorType: SelectorType.getItemsFromWhere,
          filterBy: FilterBy.key,
          key: 'key',
          operator: Operator.contains,
        );
        const json = 'key1';
        final result = JsonTools.getItemsFromWhere(json, filter);
        expect(result, 'key1');
      });

      test('Operator notContains for String', () {
        const filter = Filter(
          selectorType: SelectorType.getItemsFromWhere,
          filterBy: FilterBy.key,
          key: 'abc',
          operator: Operator.notContains,
        );
        const json = 'key1';
        final result = JsonTools.getItemsFromWhere(json, filter);
        expect(result, 'key1');
      });

      test('Operator isEmpty for String', () {
        const filter = Filter(
          selectorType: SelectorType.getItemsFromWhere,
          filterBy: FilterBy.key,
          operator: Operator.isEmpty,
        );
        const json = '';
        final result = JsonTools.getItemsFromWhere(json, filter);
        expect(result, isNull);
      });

      test('Operator isNotEmpty for String', () {
        const filter = Filter(
          selectorType: SelectorType.getItemsFromWhere,
          filterBy: FilterBy.key,
          operator: Operator.isNotEmpty,
        );
        const json = 'key1';
        final result = JsonTools.getItemsFromWhere(json, filter);
        expect(result, isNull);
      });
    });
  });
}
