import 'package:cached_network_image/cached_network_image.dart';
import 'package:ecommerce_app/models/product_model.dart';
import 'package:ecommerce_app/providers/cartProvider.dart';
import 'package:ecommerce_app/screens/product_detail.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import '../models/cart_model.dart';
import '../utils/constants.dart';
import 'image_placeholder.dart';

class ProductCard extends StatelessWidget {
  final List<Product> products;
  const ProductCard({super.key, required this.products});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: kPadding),
      child: Wrap(
        spacing: 16,
        runSpacing: 16,
        children: List.generate(
          products.length,
          (index) => ProCard(
            product: products[index],
          ),
        ),
      ),
    );
  }
}

class ProCard extends StatelessWidget {
  final Product product;
  const ProCard({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return InkWell(
      onTap: () => Navigator.push(
          context,
          MaterialPageRoute(
              builder: (builder) => DetailsScreen(product: product))),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: Theme.of(context).cardColor,
        ),
        width: size.width / 2 - 26,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
              height: 205,
              width: double.infinity,
              child: Stack(
                clipBehavior: Clip.none,
                children: [
                  ClipRRect(
                    borderRadius: const BorderRadius.only(
                        topRight: Radius.circular(8),
                        topLeft: Radius.circular(8)),
                    child: CachedNetworkImage(
                        imageUrl: '${kEndpoint}/${product.photos![0]}',
                        fit: BoxFit.cover,
                        height: 180,
                        width: double.infinity,
                        placeholder: (context, url) => const ImagePlaceholder(),

                        // ),
                        errorWidget: (context, url, error) =>
                            const ImagePlaceholder()),
                  ),
                  Positioned(
                    bottom: 12,
                    right: 8,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: Color(0xff0EBE7F),
                        borderRadius: BorderRadius.circular(24),
                        border: Border.all(
                            color: Theme.of(context).cardColor, width: 2),
                      ),
                      child: Text(
                        '\$${product.price!.toString()}',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                  Visibility(
                    visible: true,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Positioned(
                          top: 5,
                          left: 5,
                          child: Container(
                            padding: const EdgeInsets.all(5),
                            decoration: BoxDecoration(
                                color: kPrimaryColor,
                                borderRadius: BorderRadius.circular(3)),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "30% off",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 12,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Gap(70),
                        //Chart
                        InkWell(
                          onTap: () {
                            CartProvider().addToCart({
                              "name": product.name!,
                              "image": product.photos![0],
                              "price": product.price!,
                              "quantity": 1,
                              "originalPrice": product.price!
                            });

                            //  SnackBar(content: Text("Added To The Cart"));
                          },
                          child: Icon(
                            Icons.shopping_cart,
                            color: Color(0xff0EBE7F),
                            size: 35,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // const Gap(8),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: kPadding),
                  child: Text(
                    product.name!,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                const Gap(8),
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: kPadding),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 2,
                  ),
                  decoration: BoxDecoration(
                      color: kPrimaryColor.withOpacity(0.17),
                      borderRadius: BorderRadius.circular(3)),
                  child: const Text(
                    'New',
                    style: TextStyle(
                      color: kPrimaryColor,
                      fontSize: 8,
                    ),
                  ),
                ),
                const Gap(kPadding),
              ],
            ),
            const Gap(8),
          ],
        ),
      ),
    );
  }
}
