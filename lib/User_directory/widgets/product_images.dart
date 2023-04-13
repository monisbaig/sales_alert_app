import 'package:flutter/material.dart';
import 'package:flutter_image_slideshow/flutter_image_slideshow.dart';

class ProductImageSlider extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return ImageSlideshow(
      indicatorColor: Colors.redAccent,
      indicatorBackgroundColor:Colors.white,
      height: 300,
      autoPlayInterval: 2000,
      indicatorRadius: 4,
      isLoop: true,
    children: [
      Padding(padding: EdgeInsets.all(8),
      child: Image.asset("lib/User_directory/user_images/p1.png"),
      ),
    Padding(padding: EdgeInsets.all(8),
    child: Image.asset("lib/User_directory/user_images/p2.png"),),

    ],
    );
  }
}
