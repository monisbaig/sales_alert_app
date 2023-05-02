import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sales_alert_app/brands/screens/clothing/kids_category.dart';
import 'package:sales_alert_app/brands/screens/clothing/men_category.dart';
import 'package:sales_alert_app/brands/screens/clothing/women_category.dart';

class ClothingCategories extends StatelessWidget {
  const ClothingCategories({super.key});

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
                'Clothing Items ',
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
                            'lib/brands/brand_images/men.png',
                            width: 100.w,
                            height: 150.h,
                            fit: BoxFit.cover,
                          ),
                        ),
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (_) => const MenCategory(
                                mainCategory: 'Men',
                              ),
                            ),
                          );
                        },
                      ),
                      SizedBox(height: 20.h),
                      Text(
                        'Men ',
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
                            'lib/brands/brand_images/women.jpg',
                            width: 100.w,
                            height: 150.h,
                            fit: BoxFit.cover,
                          ),
                        ),
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (_) => const WomenCategory(
                                mainCategory: 'Women',
                              ),
                            ),
                          );
                        },
                      ),
                      SizedBox(height: 20.h),
                      Text(
                        'Women ',
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
                          'lib/brands/brand_images/kids.jpg',
                          width: 100.w,
                          height: 150.h,
                          fit: BoxFit.cover,
                        ),
                      ),
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (_) => const KidsCategory(
                              mainCategory: 'Kids',
                            ),
                          ),
                        );
                      },
                    ),
                    SizedBox(height: 20.h),
                    Text(
                      'Kids ',
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
