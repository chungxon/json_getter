import 'dart:convert';

import 'package:async/async.dart';
import 'package:flutter/material.dart';
import 'package:json_getter/json_getter.dart';

import '../../domain/enums/json_source_enum.dart';
import '../../domain/repository/json_repository.dart';

class HomeViewmodel extends ChangeNotifier {
  HomeViewmodel({required JsonRepository jsonRepository})
      : _jsonRepository = jsonRepository;

  final JsonRepository _jsonRepository;

  CancelableCompleter<String>? completer;

  JsonSource jsonSource = JsonSource.rawJson;
  String rawJson = '';
  bool isLoadingJson = false;

  Filters filters = Filters(filters: []);
  Map<int, String?> filterJsons = {};

  void setJsonSource(JsonSource source) {
    jsonSource = source;
    notifyListeners();
  }

  void setRawJson(String json) {
    rawJson = json;
    filters = Filters(filters: []);
    filterJsons = {};
    notifyListeners();
  }

  void clearRawJson() {
    rawJson = '';
    filters = Filters(filters: []);
    filterJsons = {};
    notifyListeners();
  }

  Future<void> getJsonFromUrl(String url) async {
    await completer?.operation.cancel();
    isLoadingJson = true;
    notifyListeners();

    try {
      completer = CancelableCompleter();
      completer?.complete(_jsonRepository.getRawJson(url));
      final json = await completer?.operation.valueOrCancellation();
      if (json != null) {
        setRawJson(json);
      }
    } finally {
      isLoadingJson = false;
      notifyListeners();
    }
  }

  void addNewFilter() {
    if (filters.filters.isEmpty) {
      filters = Filters(
        filters: [
          const Filter(),
        ],
      );
      filterJsons = {};
    } else {
      filters = filters.copyWith(
        filters: [
          ...filters.filters,
          const Filter(),
        ],
      );
      filterJsons[filters.filters.length - 1] = null;
    }
    notifyListeners();
  }

  void updateFilters(int index, Filter filter, String? json) {
    // Update current filter and emove all filters after current filter
    filters = filters.copyWith(
      filters: [
        ...filters.filters.sublist(0, index),
        filter,
      ],
    );

    filterJsons[index] = json;
    filterJsons.removeWhere((key, value) => key > index);
    notifyListeners();
  }

  void removeLastFilter() {
    filters = filters.copyWith(
      filters: [
        ...filters.filters.sublist(0, filters.filters.length - 1),
      ],
    );

    filterJsons.removeWhere((key, value) => key == filters.filters.length);
    notifyListeners();
  }

  void setFilters(Filters filters) {
    this.filters = Filters(filters: []);
    filterJsons = {};

    this.filters = filters;
    filterJsons = {};
    for (var i = 0; i < filters.filters.length; i++) {
      if (i == 0) {
        filterJsons[i] = jsonEncode(
          JsonGetter.getFromFilter(
            filter: filters.filters[i],
            json: rawJson,
          ),
        );
      } else {
        filterJsons[i] = jsonEncode(
          JsonGetter.getFromFilter(
            filter: filters.filters[i],
            json: filterJsons[i - 1],
          ),
        );
      }
    }
    notifyListeners();
  }
}
