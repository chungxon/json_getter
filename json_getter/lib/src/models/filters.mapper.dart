// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'filters.dart';

class FiltersMapper extends ClassMapperBase<Filters> {
  FiltersMapper._();

  static FiltersMapper? _instance;
  static FiltersMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = FiltersMapper._());
      FilterMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'Filters';

  static List<Filter> _$filters(Filters v) => v.filters;
  static const Field<Filters, List<Filter>> _f$filters =
      Field('filters', _$filters);

  @override
  final MappableFields<Filters> fields = const {
    #filters: _f$filters,
  };

  static Filters _instantiate(DecodingData data) {
    return Filters(filters: data.dec(_f$filters));
  }

  @override
  final Function instantiate = _instantiate;

  static Filters fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<Filters>(map);
  }

  static Filters fromJson(String json) {
    return ensureInitialized().decodeJson<Filters>(json);
  }
}

mixin FiltersMappable {
  String toJson() {
    return FiltersMapper.ensureInitialized()
        .encodeJson<Filters>(this as Filters);
  }

  Map<String, dynamic> toMap() {
    return FiltersMapper.ensureInitialized()
        .encodeMap<Filters>(this as Filters);
  }

  FiltersCopyWith<Filters, Filters, Filters> get copyWith =>
      _FiltersCopyWithImpl(this as Filters, $identity, $identity);
  @override
  String toString() {
    return FiltersMapper.ensureInitialized().stringifyValue(this as Filters);
  }

  @override
  bool operator ==(Object other) {
    return FiltersMapper.ensureInitialized()
        .equalsValue(this as Filters, other);
  }

  @override
  int get hashCode {
    return FiltersMapper.ensureInitialized().hashValue(this as Filters);
  }
}

extension FiltersValueCopy<$R, $Out> on ObjectCopyWith<$R, Filters, $Out> {
  FiltersCopyWith<$R, Filters, $Out> get $asFilters =>
      $base.as((v, t, t2) => _FiltersCopyWithImpl(v, t, t2));
}

abstract class FiltersCopyWith<$R, $In extends Filters, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  ListCopyWith<$R, Filter, FilterCopyWith<$R, Filter, Filter>> get filters;
  $R call({List<Filter>? filters});
  FiltersCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class _FiltersCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, Filters, $Out>
    implements FiltersCopyWith<$R, Filters, $Out> {
  _FiltersCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<Filters> $mapper =
      FiltersMapper.ensureInitialized();
  @override
  ListCopyWith<$R, Filter, FilterCopyWith<$R, Filter, Filter>> get filters =>
      ListCopyWith($value.filters, (v, t) => v.copyWith.$chain(t),
          (v) => call(filters: v));
  @override
  $R call({List<Filter>? filters}) =>
      $apply(FieldCopyWithData({if (filters != null) #filters: filters}));
  @override
  Filters $make(CopyWithData data) =>
      Filters(filters: data.get(#filters, or: $value.filters));

  @override
  FiltersCopyWith<$R2, Filters, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t) =>
      _FiltersCopyWithImpl($value, $cast, t);
}
