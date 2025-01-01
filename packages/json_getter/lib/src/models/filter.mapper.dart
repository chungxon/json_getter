// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'filter.dart';

class FilterMapper extends ClassMapperBase<Filter> {
  FilterMapper._();

  static FilterMapper? _instance;
  static FilterMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = FilterMapper._());
      SelectorTypeMapper.ensureInitialized();
      FilterByMapper.ensureInitialized();
      OperatorMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'Filter';

  static SelectorType? _$selectorType(Filter v) => v.selectorType;
  static const Field<Filter, SelectorType> _f$selectorType =
      Field('selectorType', _$selectorType, opt: true);
  static FilterBy? _$filterBy(Filter v) => v.filterBy;
  static const Field<Filter, FilterBy> _f$filterBy =
      Field('filterBy', _$filterBy, opt: true);
  static String? _$key(Filter v) => v.key;
  static const Field<Filter, String> _f$key = Field('key', _$key, opt: true);
  static Operator? _$operator(Filter v) => v.operator;
  static const Field<Filter, Operator> _f$operator =
      Field('operator', _$operator, opt: true);
  static dynamic _$value(Filter v) => v.value;
  static const Field<Filter, dynamic> _f$value =
      Field('value', _$value, opt: true);

  @override
  final MappableFields<Filter> fields = const {
    #selectorType: _f$selectorType,
    #filterBy: _f$filterBy,
    #key: _f$key,
    #operator: _f$operator,
    #value: _f$value,
  };

  static Filter _instantiate(DecodingData data) {
    return Filter(
        selectorType: data.dec(_f$selectorType),
        filterBy: data.dec(_f$filterBy),
        key: data.dec(_f$key),
        operator: data.dec(_f$operator),
        value: data.dec(_f$value));
  }

  @override
  final Function instantiate = _instantiate;

  static Filter fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<Filter>(map);
  }

  static Filter fromJson(String json) {
    return ensureInitialized().decodeJson<Filter>(json);
  }
}

mixin FilterMappable {
  String toJson() {
    return FilterMapper.ensureInitialized().encodeJson<Filter>(this as Filter);
  }

  Map<String, dynamic> toMap() {
    return FilterMapper.ensureInitialized().encodeMap<Filter>(this as Filter);
  }

  FilterCopyWith<Filter, Filter, Filter> get copyWith =>
      _FilterCopyWithImpl(this as Filter, $identity, $identity);
  @override
  String toString() {
    return FilterMapper.ensureInitialized().stringifyValue(this as Filter);
  }

  @override
  bool operator ==(Object other) {
    return FilterMapper.ensureInitialized().equalsValue(this as Filter, other);
  }

  @override
  int get hashCode {
    return FilterMapper.ensureInitialized().hashValue(this as Filter);
  }
}

extension FilterValueCopy<$R, $Out> on ObjectCopyWith<$R, Filter, $Out> {
  FilterCopyWith<$R, Filter, $Out> get $asFilter =>
      $base.as((v, t, t2) => _FilterCopyWithImpl(v, t, t2));
}

abstract class FilterCopyWith<$R, $In extends Filter, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  $R call(
      {SelectorType? selectorType,
      FilterBy? filterBy,
      String? key,
      Operator? operator,
      dynamic value});
  FilterCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class _FilterCopyWithImpl<$R, $Out> extends ClassCopyWithBase<$R, Filter, $Out>
    implements FilterCopyWith<$R, Filter, $Out> {
  _FilterCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<Filter> $mapper = FilterMapper.ensureInitialized();
  @override
  $R call(
          {Object? selectorType = $none,
          Object? filterBy = $none,
          Object? key = $none,
          Object? operator = $none,
          Object? value = $none}) =>
      $apply(FieldCopyWithData({
        if (selectorType != $none) #selectorType: selectorType,
        if (filterBy != $none) #filterBy: filterBy,
        if (key != $none) #key: key,
        if (operator != $none) #operator: operator,
        if (value != $none) #value: value
      }));
  @override
  Filter $make(CopyWithData data) => Filter(
      selectorType: data.get(#selectorType, or: $value.selectorType),
      filterBy: data.get(#filterBy, or: $value.filterBy),
      key: data.get(#key, or: $value.key),
      operator: data.get(#operator, or: $value.operator),
      value: data.get(#value, or: $value.value));

  @override
  FilterCopyWith<$R2, Filter, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t) =>
      _FilterCopyWithImpl($value, $cast, t);
}
