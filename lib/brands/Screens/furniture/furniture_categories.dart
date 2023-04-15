import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sales_alert_app/brands/Screens/furniture/furniture_items.dart';

class FurnitureCategories extends StatelessWidget {
  const FurnitureCategories({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(height: 100.h),
            Center(
              child: Text(
                'Choose a ',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 40.sp,
                ),
              ),
            ),
            Center(
              child: Text(
                'Subcategory ',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 40.sp,
                ),
              ),
            ),
            SizedBox(height: 20.h),
            Center(
              child: Text(
                'Furniture Items ',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16.sp,
                ),
              ),
            ),
            SizedBox(height: 80.h),
            Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Column(
                    children: [
                      GestureDetector(
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(26.r),
                          child: Image.asset(
                            'lib/brands/brand_images/sofa.png',
                            height: 130.h,
                            fit: BoxFit.cover,
                          ),
                        ),
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (_) => const FurnitureItems(
                                mainCategory: 'Sofa Set',
                              ),
                            ),
                          );
                        },
                      ),
                      SizedBox(height: 20.h),
                      Text(
                        'Sofa Set',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16.sp,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(width: 50.w),
                  Column(
                    children: [
                      GestureDetector(
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(26.r),
                          child: Image.asset(
                            'lib/brands/brand_images/bed.png',
                            height: 130.h,
                            fit: BoxFit.cover,
                          ),
                        ),
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (_) => const FurnitureItems(
                                mainCategory: 'Bed Set',
                              ),
                            ),
                          );
                        },
                      ),
                      SizedBox(height: 20.h),
                      Text(
                        'Bed Set',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16.sp,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(height: 50.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Column(
                  children: [
                    GestureDetector(
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(26.r),
                        child: Image.asset(
                          'lib/brands/brand_images/table.png',
                          height: 130.h,
                          fit: BoxFit.cover,
                        ),
                      ),
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (_) => const FurnitureItems(
                              mainCategory: 'Table Set',
                            ),
                          ),
                        );
                      },
                    ),
                    SizedBox(height: 20.h),
                    Text(
                      'Table Set',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16.sp,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(height: 50.h),
          ],
        ),
      ),
    );
  }
}
