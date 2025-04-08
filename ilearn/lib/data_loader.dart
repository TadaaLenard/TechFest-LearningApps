import 'dart:convert';
import 'package:flutter/services.dart';

Future<List<T>> loadDataFromJson<T>(
    String path, T Function(Map<String, dynamic>) fromJson) async {
  final String jsonString = await rootBundle.loadString(path);
  final List<dynamic> jsonList = json.decode(jsonString);
  return jsonList.map((json) => fromJson(json)).toList();
}
