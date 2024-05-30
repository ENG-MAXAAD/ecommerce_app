import 'package:ecommerce_app/models/product_model.dart';
import 'package:ecommerce_app/services/product.dart';
import 'package:flutter/material.dart';

enum LoginState { normal, loading, error, networkError, success }

class ProductProvider extends ChangeNotifier {
  List<Product> product = [];

  Future<void> getProducts() async {
    // try {
    //   product = await ProductServices().getProducts();
    // } catch (e) {
    //   print(e);
    // }

    product = await ProductServices().getProducts();
    notifyListeners();
  }
}
