import 'package:ecommerce_app/models/category_model.dart';
import 'package:ecommerce_app/models/user_model.dart';
import 'package:ecommerce_app/services/category.dart';
import 'package:ecommerce_app/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';

import '../models/category_specialist.dart';
import '../services/user.dart';

enum LoginState { normal, loading, error, networkError, success }

class CategoryProvider extends ChangeNotifier {
  List<CategoryModel> category = [];
  var isLoading = false;
  List<ProductCategoryModel> productsByCategory = [];

  Future<void> getCategories() async {
    try {
      category = await CategoryServices().getCategories();
      notifyListeners();
    } catch (e) {
      print(e);
      notifyListeners();
    }
  }

  Future<void> getCategoryByProduct(String categoryId) async {
    try {
      isLoading = true;
      notifyListeners();
      productsByCategory =
          await CategoryServices().getProductsByCategory(categoryId);
      isLoading = false;
      notifyListeners();
    } catch (e) {
      isLoading = false;
      print(e);
      notifyListeners();
    }
  }
}
