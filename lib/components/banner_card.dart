import 'package:banner_carousel/banner_carousel.dart';
import 'package:ecommerce_app/services/banner.dart';
import 'package:flutter/material.dart';

import '../models/banner.dart';

class BannerCard extends StatelessWidget {
  final List<BannerModels> banner;
  BannerCard({super.key, required this.banner});

  @override
  Widget build(BuildContext context) {
    // Convert the list of Banner objects to a list of BannerModel objects
    List<BannerModel> Banners = banner.map((banner) {
      return BannerModel(id: banner.id![0], imagePath: banner.photo![0]);
    }).toList();

    // Return the BannerCarousel widget with the converted list of BannerModel objects
    return BannerCarousel(animation: true, banners: Banners);
  }
}
