import 'package:ecommerce_app/providers/category.dart';
import 'package:ecommerce_app/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProductCardList extends StatefulWidget {
  final String? cateroryId;
  const ProductCardList({super.key, this.cateroryId});

  @override
  State<ProductCardList> createState() => _CategoryListScreenState();
}

class _CategoryListScreenState extends State<ProductCardList> {
  @override
  Widget build(BuildContext context) {
    var product = Provider.of<CategoryProvider>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        title: Text("Product Category"),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            mainAxisExtent: 240,
            crossAxisCount: 2,
            crossAxisSpacing: 10,
            mainAxisSpacing: 20,
          ),
          itemCount: product.productsByCategory.length,
          itemBuilder: (context, index) => Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClipRRect(
                  borderRadius:
                      BorderRadius.vertical(top: Radius.circular(10.0)),
                  child: Image.network(
                    "${kEndpoint}/${product.productsByCategory[index].photos![0]}",
                    height: 100.0,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    Provider.of<CategoryProvider>(context, listen: false)
                        .productsByCategory[index]
                        .name!,
                    style: TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Text(
                    "This is a short description of the category.",
                    style: TextStyle(
                      fontSize: 14.0,
                      color: Colors.grey[600],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
