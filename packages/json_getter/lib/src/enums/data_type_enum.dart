enum DataType {
  string,
  number,
  boolean,
  list,
  map,
  nullable,
  ;

  static DataType getType(dynamic json) {
    if (json is String) {
      return DataType.string;
    } else if (json is num) {
      return DataType.number;
    } else if (json is bool) {
      return DataType.boolean;
    } else if (json is List) {
      return DataType.list;
    } else if (json is Map) {
      return DataType.map;
    }
    return DataType.nullable;
  }
}
