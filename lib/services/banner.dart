import 'dart:convert';

import 'package:ecommerce_app/models/banner.dart';
import 'package:ecommerce_app/models/product_model.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import '../utils/constants.dart';

class BannerServices {
  final box = GetStorage();
  Future<List<BannerModels>> getBanners() async {
    List<BannerModels> banners = [];
    var response = await http.get(
      Uri.parse("$kEndpoint/banner/"),
    );
    if (response.statusCode == 200) {
      final json = jsonDecode(response.body);
      banners = (json["banners"] as List)
          .map((e) => BannerModels.fromJson(e))
          .toList();
      print("banners is ${banners[0].name}");
    } else {
      final json = jsonDecode(response.body);
      throw json["error"];
    }
    return banners;
  }
}
