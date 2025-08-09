# JsonGetter

This package is a useful Flutter tool to extract values from JSON.

## Features

- Easily extract values from JSON structures.
- Support for multiple filters to refine data extraction.

## Getting started

To use this package, ensure you have Flutter installed and add the package to
your `pubspec.yaml`.

1. Add the package to your `pubspec.yaml` file:

```yaml
dependencies:
  json_getter: ^0.0.1
```

2. Import the package in your Dart file:

```dart
import 'package:json_getter/json_getter.dart';
```

## Usage

### With JSON String

```dart
const jsonString = '{"key1": "value1", "key2": "value2"}';
final filters = FiltersMapper.fromJson(
    '{"filters":[{"selectorType":"getValueByKey","filterBy":null,"key":"key1","operator":null,"value":null}]}',
);

final result = JsonGetter.get(filters: filters, json: jsonString);
print(result); // Output: value1
```

### With JSON Map

```dart
const jsonString = {'key1': 'value1', 'key2': 'value2'};
final filters = Filters(
  filters: [
    const Filter(
      selectorType: SelectorType.getValueByKey,
      key: 'key1',
    ),
  ],
);

final result = JsonGetter.get(filters: filters, json: jsonString);
print(result); // Output: value1
```

## Demo

[Json Getter Builder](https://chungxon.github.io/json_getter/)

<a href="https://chungxon.github.io/json_getter/" rel="Json Getter
Builder">![image info](./../../repo/json_getter.gif)</a>

## Additional information

For more information, visit the [GitHub
repository](https://github.com/chungxon/json_getter).

## License

MIT License
