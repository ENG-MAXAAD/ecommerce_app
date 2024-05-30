import 'package:ecommerce_app/models/cart_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:hive/hive.dart';
import 'package:http/http.dart';

class CartProvider extends ChangeNotifier {
  var _box = Hive.box("cart");
  List<Cart> cartData = [];

  Future<void> addToCart(Map<String, dynamic> data) async {
    var hasValue = await hasData(data['name']);
    if (hasValue) return;
    await _box.add(data);
    notifyListeners();
  }

  Future<void> deleteCartItem(key) async {
    await _box.deleteAt(key);
  }

  Future<void> getCartItems() async {
    cartData = _box.keys.map((key) {
      var cartItem = _box.get(key);
      var item = {
        "name": cartItem["name"],
        "price": cartItem['price'],
        "originalPrice": cartItem['originalPrice'],
        "image": "",
        "cat": "t",
        "productID": 1
      };
      return Cart.fromJson(item);
    }).toList();
    notifyListeners();
  }

  Future<void> updateAt(key, Map<String, dynamic> value) async {
    await _box.put(key, value);
  }

  Future<bool> hasData(String name) async {
    var actualData = _box.keys.map((cartItemKey) {
      var data = _box.get(cartItemKey);
      if (data['name'] == name) return {"name": data['name']};
    }).toList();
    return actualData.length > 0;
  }
}
