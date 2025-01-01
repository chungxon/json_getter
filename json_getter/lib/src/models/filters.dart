import 'package:dart_mappable/dart_mappable.dart';

import 'filter.dart';

part 'filters.mapper.dart';

@MappableClass()
class Filters with FiltersMappable {
  Filters({
    required this.filters,
  });

  List<Filter> filters;
}
