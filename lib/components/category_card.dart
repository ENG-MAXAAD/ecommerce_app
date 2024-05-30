import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:ecommerce_app/models/category_specialist.dart';
import 'package:ecommerce_app/models/product_model.dart';
import 'package:ecommerce_app/providers/category.dart';
import 'package:ecommerce_app/screens/product_category.dart';
import 'package:ecommerce_app/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/category_model.dart';
import '../screens/productByCategoryList.dart';
import 'image_placeholder.dart';

class CategoryCard extends StatelessWidget {
  final List<CategoryModel> categories;
  CategoryCard({super.key, required this.categories});

  @override
  Widget build(BuildContext context) {
    double childAspectRatio = 1 / 1.2;
    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 4,
        childAspectRatio: childAspectRatio,
        crossAxisSpacing: 0, // Adjust the spacing as needed
        mainAxisSpacing: 10, // Adjust the spacing as needed
      ),
      shrinkWrap: true,
      padding: const EdgeInsets.symmetric(horizontal: kPadding),
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) {
        return CatCard(categoy: categories[index]);
      },
      itemCount: categories.length,
    );
  }
}

class CatCard extends StatelessWidget {
  final CategoryModel categoy;
  const CatCard({
    super.key,
    required this.categoy,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Theme.of(context).scaffoldBackgroundColor,
          borderRadius: BorderRadius.circular(8)),
      child: Material(
        color: Theme.of(context).scaffoldBackgroundColor,
        child: InkWell(
          borderRadius: BorderRadius.circular(8),
          onTap: () {
            Provider.of<CategoryProvider>(context, listen: false)
                .getCategoryByProduct(categoy.categoryId!)
                .then((onValue) => {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (_) => ProductCardList(
                                  cateroryId: categoy.categoryId!)))
                    });
          },
          child: Column(
            children: [
              Expanded(
                flex: 2,
                child: Container(
                  width: double.infinity,
                  margin: const EdgeInsets.symmetric(
                      horizontal: kPadding, vertical: 8),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                  decoration: BoxDecoration(
                      color: Theme.of(context).cardColor,
                      borderRadius: BorderRadius.circular(8)),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: CachedNetworkImage(
                        imageUrl: "${kEndpoint}/${categoy.photo!}",
                        fit: BoxFit.cover,
                        placeholder: (context, url) => const ImagePlaceholder(),
                        errorWidget: (context, url, error) =>
                            const ImagePlaceholder()),
                  ),
                ),
              ),
              Expanded(
                child: Text(
                  categoy.name ?? "",
                  style: const TextStyle(fontSize: 12),
                  maxLines: 2,
                  textAlign: TextAlign.center,
                  overflow: TextOverflow.ellipsis,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  String getRandomCategory(List<String> categories) {
    final random = Random();
    int index = random.nextInt(categories.length);
    return categories[index];
  }
}
