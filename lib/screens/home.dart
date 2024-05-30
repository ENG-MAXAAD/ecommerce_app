import 'dart:async';

import 'package:after_layout/after_layout.dart';
import 'package:ecommerce_app/components/category_card.dart';
import 'package:ecommerce_app/providers/category.dart';
import 'package:ecommerce_app/providers/user.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:provider/provider.dart';

import '../components/banner_card.dart';
import '../components/header_card.dart';
import '../components/product_card.dart';
import '../components/search_card.dart';
import '../models/category_model.dart';
import '../providers/banner.dart';
import '../providers/product.dart';
import '../utils/constants.dart';
import 'category_list.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with AfterLayoutMixin {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kPrimaryColor,
        leading: const SizedBox(),
        toolbarHeight: 0,
      ),
      body: CustomScrollView(
        slivers: [
          SliverList(
            delegate: SliverChildListDelegate(
              [
                const Gap(kPadding),
                Consumer<UserProvider>(builder: (context, cont, child) {
                  return HeaderCard(
                    user: cont.user,
                  );
                }),
                const Gap(kPadding),
                const SearchCard(),
                const Gap(kPadding),
                Consumer<BannerProvider>(builder: (context, cont, child) {
                  return BannerCard(
                    banner: cont.banner,
                  );
                }),
                const Gap(kPadding),
                Consumer<CategoryProvider>(builder: (context, cont, child) {
                  return CategoryCard(
                    categories: cont.category,
                  );
                }),
                const Gap(kPadding),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: kPadding),
                  child: Text("Trending Products 🔥"),
                ),
                Gap(kPadding),
                Consumer<ProductProvider>(builder: (context, cont, child) {
                  return ProductCard(
                    products: (cont.product),
                  );
                }),
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  FutureOr<void> afterFirstLayout(BuildContext context) {
    Provider.of<UserProvider>(context, listen: false).getUser();
    Provider.of<CategoryProvider>(context, listen: false).getCategories();
    Provider.of<ProductProvider>(context, listen: false).getProducts();
    Provider.of<BannerProvider>(context, listen: false).getBanners();
  }
}
