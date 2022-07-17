import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';

class NetworkService {
  final baseUrl = "http://10.0.2.2:3000";
  final headers = {"Content-Type": "application/json"};

  Future<Map<String, dynamic>?> addTodo(Map<String, dynamic> todoObj) async {
    try {
      final res = await post(Uri.parse("$baseUrl/todos"), headers: headers, body: jsonEncode(todoObj));
      final data = jsonDecode(res.body);
      debugPrint("addTodo data -> ${data.toString()}");
      return data;
    } catch (err) {
      debugPrint("addTodo err -> ${err.toString()}");
      return null;
    }
  }

  Future<List<dynamic>> fetchTodos() async {
    try {
      final res = await get(Uri.parse("$baseUrl/todos"));
      final data = jsonDecode(res.body) as List;
      debugPrint("fetchTodos data -> ${data.toString()}");
      return data;
    } catch (err) {
      debugPrint("fetchTodos err -> ${err.toString()}");
      return [];
    }
  }

  Future<bool> patchTodo(int id, Map<String, dynamic> obj) async {
    try {
      final res = await patch(Uri.parse("$baseUrl/todos/$id"), headers: headers, body: jsonEncode(obj));
      final data = jsonDecode(res.body);
      debugPrint("patchTodo data -> ${data.toString()}");
      return true;
    } catch (err) {
      debugPrint("patchTodo err -> ${err.toString()}");
      return false;
    }
  }

  Future<bool> deleteTodo(int id) async {
    try {
      final res = await delete(Uri.parse("$baseUrl/todos/$id"));
      final data = jsonDecode(res.body);
      debugPrint("deleteTodo data -> ${data.toString()}");
      return true;
    } catch (err) {
      debugPrint("deleteTodo err -> ${err.toString()}");
      return false;
    }
  }
}
