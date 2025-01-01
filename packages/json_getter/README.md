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

```dart
const jsonString = '{"key1": "value1", "key2": "value2"}';
final filters = FiltersMapper.fromJson(
    '{"filters":[{"selectorType":"getValueByKey","filterBy":null,"key":"key1","operator":null,"value":null}]}',
);

final result = JsonGetter.get(filters: filters, json: jsonString);
print(result); // Output: value1
```

## Demo
![image info](https://github.com/chungxon/json_getter/blob/master/repo/json_getter.gif?raw=true)

## Additional information

For more information, visit the [GitHub
repository](https://github.com/chungxon/json_getter).

## License

MIT License
