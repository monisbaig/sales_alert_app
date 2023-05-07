import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'clothing_items.dart';

class KidsCategory extends StatelessWidget {
  final String mainCategory;

  const KidsCategory({super.key, required this.mainCategory});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Column(children: [
          Stack(
            children: [
              Image.asset(
                'lib/brands/brand_images/kids_clothing.jpg',
              ),
              Positioned.fill(
                child: Align(
                  alignment: Alignment.center,
                  child: Text(
                    "Kid's Items ",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 30.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 20.h),
          Container(
            alignment: Alignment.topLeft,
            //margin: EdgeInsets.only(left: 15.w),
            child: Text(
              "Choose Category",
              style: TextStyle(
                color: Colors.white,
                fontSize: 20.sp,
              ),
            ),
          ),
          SizedBox(height: 20.h),
          const Divider(
            thickness: 0.5,
            color: Color(0xFFD7B4B4),
          ),
          SizedBox(height: 10.h),
          Container(
            alignment: Alignment.topLeft,
            //margin: EdgeInsets.only(left: 15.w),
            child: GestureDetector(
              child: Text(
                "Shirt",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20.sp,
                ),
              ),
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (_) => ClothingItems(
                      mainCategory: mainCategory,
                      subCategory: 'Shirts',
                    ),
                  ),
                );
              },
            ),
          ),
          SizedBox(height: 10.h),
          const Divider(
            thickness: 0.5,
            color: Color(0xFFD7B4B4),
          ),
          SizedBox(height: 10.h),
          Container(
            alignment: Alignment.topLeft,
            //margin: EdgeInsets.only(left: 15.w),
            child: GestureDetector(
              child: Text(
                "Pants",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20.sp,
                ),
              ),
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (_) => ClothingItems(
                      mainCategory: mainCategory,
                      subCategory: 'Pants',
                    ),
                  ),
                );
              },
            ),
          ),
          SizedBox(height: 10.h),
          const Divider(
            thickness: 0.5,
            color: Color(0xFFD7B4B4),
          ),
          SizedBox(height: 10.h),
          Container(
            alignment: Alignment.topLeft,
            //margin: EdgeInsets.only(left: 15.w),
            child: GestureDetector(
              child: Text(
                "Trousers",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20.sp,
                ),
              ),
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (_) => ClothingItems(
                      mainCategory: mainCategory,
                      subCategory: 'Trousers',
                    ),
                  ),
                );
              },
            ),
          ),
          SizedBox(height: 10.h),
          const Divider(
            thickness: 0.5,
            color: Color(0xFFD7B4B4),
          ),
          SizedBox(height: 10.h),
          Container(
            alignment: Alignment.topLeft,
            //margin: EdgeInsets.only(left: 15.w),
            child: GestureDetector(
              child: Text(
                "Shoes",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20.sp,
                ),
              ),
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (_) => ClothingItems(
                      mainCategory: mainCategory,
                      subCategory: 'Shoes',
                    ),
                  ),
                );
              },
            ),
          ),
          SizedBox(height: 10.h),
          const Divider(
            thickness: 0.5,
            color: Color(0xFFD7B4B4),
          ),
          SizedBox(height: 10.h),
          Container(
            alignment: Alignment.topLeft,
            //margin: EdgeInsets.only(left: 15.w),
            child: GestureDetector(
              child: Text(
                "Accessories",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20.sp,
                ),
              ),
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (_) => ClothingItems(
                      mainCategory: mainCategory,
                      subCategory: 'Accessories',
                    ),
                  ),
                );
              },
            ),
          ),
          SizedBox(height: 10.h),
          const Divider(
            thickness: 0.5,
            color: Color(0xFFD7B4B4),
          ),
        ]),
      ),
    );
  }
}
