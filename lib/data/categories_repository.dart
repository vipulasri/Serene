import 'package:flutter/services.dart';
import 'package:serene/config/assets.dart';
import 'package:serene/model/category.dart';

class CategoriesRepository {

  // in-memory categories
  List<Category> categories = <Category>[];

  Future<String> _loadCategoriesAsset() async {
    return await rootBundle.loadString(Assets.soundsJson);
  }

  Future<List<Category>> loadCategories() async {
    if(categories.isNotEmpty) {
      return categories;
    }

    String jsonString = await _loadCategoriesAsset();
    categories.clear();
    categories.addAll(categoryFromJson(jsonString));
    return categories;
  }

}