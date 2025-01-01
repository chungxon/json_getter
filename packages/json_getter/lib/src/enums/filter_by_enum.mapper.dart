// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'filter_by_enum.dart';

class FilterByMapper extends EnumMapper<FilterBy> {
  FilterByMapper._();

  static FilterByMapper? _instance;
  static FilterByMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = FilterByMapper._());
    }
    return _instance!;
  }

  static FilterBy fromValue(dynamic value) {
    ensureInitialized();
    return MapperContainer.globals.fromValue(value);
  }

  @override
  FilterBy decode(dynamic value) {
    switch (value) {
      case 'key':
        return FilterBy.key;
      case 'value':
        return FilterBy.value;
      default:
        throw MapperException.unknownEnumValue(value);
    }
  }

  @override
  dynamic encode(FilterBy self) {
    switch (self) {
      case FilterBy.key:
        return 'key';
      case FilterBy.value:
        return 'value';
    }
  }
}

extension FilterByMapperExtension on FilterBy {
  String toValue() {
    FilterByMapper.ensureInitialized();
    return MapperContainer.globals.toValue<FilterBy>(this) as String;
  }
}
