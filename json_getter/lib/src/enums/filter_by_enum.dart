import 'package:dart_mappable/dart_mappable.dart';

part 'filter_by_enum.mapper.dart';

@MappableEnum()
enum FilterBy {
  key,
  value,
}

extension FilterByExtension on FilterBy {
  bool get isByKey => this == FilterBy.key;
  bool get isByValue => this == FilterBy.value;
}
