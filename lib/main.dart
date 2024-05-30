import 'package:ecommerce_app/models/category_specialist.dart';
import 'package:ecommerce_app/providers/banner.dart';
import 'package:ecommerce_app/providers/cartProvider.dart';
import 'package:ecommerce_app/providers/category.dart';
import 'package:ecommerce_app/providers/product.dart';
import 'package:ecommerce_app/providers/user.dart';
import 'package:ecommerce_app/screens/category_list.dart';
import 'package:ecommerce_app/screens/home.dart';
import 'package:ecommerce_app/screens/login.dart';
import 'package:ecommerce_app/screens/order_screen.dart';
import 'package:ecommerce_app/screens/productByCategoryList.dart';
import 'package:ecommerce_app/screens/product_category.dart';
import 'package:ecommerce_app/screens/product_detail.dart';
import 'package:ecommerce_app/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get_storage/get_storage.dart';
import 'package:provider/provider.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  await GetStorage.init();
  final box = GetStorage();
  await Hive.openBox("cart");
  bool isLogin = box.hasData(kUserInfo);
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => UserProvider()),
        ChangeNotifierProvider(create: (context) => CategoryProvider()),
        ChangeNotifierProvider(create: (context) => ProductProvider()),
        ChangeNotifierProvider(create: (context) => BannerProvider()),
        ChangeNotifierProvider(create: (context) => CartProvider()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: "E-commerce App",
        // home: const ProductCategoryList(),
        // home: CartScreen(),
        home: isLogin ? HomeScreen() : const LoginScreen(),
        theme: ThemeData(),
      ),
    ),
  );
}
