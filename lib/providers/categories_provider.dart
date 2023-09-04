import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../helpers/config.dart';

import '../models/categorie.dart';

class CategoryProvider extends ChangeNotifier {
  List<Category> _categories = [];

  List<Category> get categories => _categories;

  Future<bool> fetchCategories() async {
    var response = await http.get(
      Uri.parse("${url}category"),
      headers: {"Content-Type": "application/json"},
    );

    if (response.statusCode == 200) {
      _categories = (json.decode(response.body)["category"] as List)
          .map((e) => Category.fromJson(e))
          .toList();

      notifyListeners();
      return true; // Add this return statement to indicate success
    } else {
      throw Exception('Failed to load provider categories');
    }
  }
}
