import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../../domain/repository/json_repository.dart';

class JsonRepositoryImpl implements JsonRepository {
  @override
  Future<String> getRawJson(String url) async {
    debugPrint('[HTTP Get] $url');
    final uri = Uri.tryParse(url);

    if (uri == null) {
      throw Exception('Invalid URL');
    }

    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      // Use Utf8Decoder to decode the response body instead of using
      // response.body directly to avoid encoding issues with special language
      return const Utf8Decoder().convert(response.bodyBytes);
    } else {
      throw Exception('Failed to load JSON');
    }
  }
}
