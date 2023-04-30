import 'package:flutter/material.dart';
import 'package:flutter_image_slideshow/flutter_image_slideshow.dart';

class ProductImageSlider extends StatelessWidget {
  final String productImage;

  const ProductImageSlider({super.key, required this.productImage});

  @override
  Widget build(BuildContext context) {
    return ImageSlideshow(
      indicatorColor: Colors.redAccent,
      indicatorBackgroundColor: Colors.white,
      height: 300,
      autoPlayInterval: 2000,
      indicatorRadius: 4,
      isLoop: true,
      children: [
        Padding(
          padding: const EdgeInsets.all(8),
          child: Image.network(productImage),
        ),
        Padding(
          padding: const EdgeInsets.all(8),
          child: Image.network(productImage),
        ),
      ],
    );
  }
}
