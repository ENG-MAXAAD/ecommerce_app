import 'package:ecommerce_app/models/product_model.dart';
import 'package:ecommerce_app/services/banner.dart';
import 'package:ecommerce_app/services/product.dart';
import 'package:flutter/material.dart';

import '../models/banner.dart';

enum LoginState { normal, loading, error, networkError, success }

class BannerProvider extends ChangeNotifier {
  List<BannerModels> banner = [];

  Future<void> getBanners() async {
    // try {
    //   product = await ProductServices().getProducts();
    // } catch (e) {
    //   print(e);
    // }
    banner = await BannerServices().getBanners();

    notifyListeners();
  }
}
