import 'dart:convert';

import 'package:ecommerce_app/models/product_model.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import '../utils/constants.dart';

class ProductServices {
  final box = GetStorage();
  Future<List<Product>> getProducts() async {
    List<Product> products = [];
    var response = await http.get(
      Uri.parse("$kEndpoint/product/"),
    );
    if (response.statusCode == 200) {
      final json = jsonDecode(response.body);
      products =
          (json["products"] as List).map((e) => Product.fromJson(e)).toList();
      print("pro is ${products[0].name}");
    } else {
      final json = jsonDecode(response.body);
      throw json["error"];
    }
    return products;
  }
}
