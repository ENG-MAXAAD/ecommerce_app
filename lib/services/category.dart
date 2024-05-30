import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:ecommerce_app/models/category_model.dart';
import 'package:ecommerce_app/utils/constants.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;

import '../models/category_specialist.dart';
import '../models/user_model.dart';

class CategoryServices {
  final box = GetStorage();
  Future<List<CategoryModel>> getCategories() async {
    List<CategoryModel> categories = [];
    var response = await http.get(
      Uri.parse("$kEndpoint/category/"),
    );
    if (response.statusCode == 200) {
      final json = jsonDecode(response.body);
      categories =
          (json as List).map((e) => CategoryModel.fromJson(e)).toList();
      print("ca is ${categories[0].photo}");
    } else {
      final json = jsonDecode(response.body);
      throw json["error"];
    }
    return categories;
  }

  ///Category Specialist

  // Future<List<ProductByCategory>> getProductByCategory(
  //     String categoryId) async {
  //   List<ProductByCategory> categories = [];
  //   var response = await http.get(
  //     Uri.parse("$kEndpoint/category/$categoryId"),
  //   );
  //   if (response.statusCode == 200) {
  //     final json = jsonDecode(response.body);
  //     categories =
  //         (json as List).map((e) => ProductByCategory.fromJson(e)).toList();
  //     // print("category Specialist is ${categories[0].photo}");
  //   } else {
  //     final json = jsonDecode(response.body);
  //     throw json["error"];
  //   }
  //   return categories;
  // }

  Future<List<ProductCategoryModel>> getProductsByCategory(
      String categoryId) async {
    try {
      var url = Uri.parse("$kEndpoint/product/productCategory/$categoryId");
      var response = await http.get(url, headers: {
        HttpHeaders.contentTypeHeader: "application/json",
      });

      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);
        var d = (data['products'] as List)
            .map((value) => ProductCategoryModel.fromJson(value))
            .toList();
        return d;
      } else if (response.statusCode == 404) {
        throw Exception('No Data Found for category $categoryId');
      } else {
        throw Exception('Failed to load products for category $categoryId');
      }
    } catch (e) {
      print('Error fetching products for category $categoryId: $e');
      rethrow;
    }
  }
}
