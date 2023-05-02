import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../inventory/total_inventory.dart';

class ElectronicsInventory extends StatelessWidget {
  const ElectronicsInventory({super.key});

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
                'Choose a',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 40.sp,
                ),
              ),
            ),
            Center(
              child: Text(
                'Subcategory',
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
                'Total Inventory',
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
                            'lib/brands/brand_images/mobile.png',
                            height: 130.h,
                            fit: BoxFit.cover,
                          ),
                        ),
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (_) => const TotalInventory(
                                collection: 'Mobile Phones',
                              ),
                            ),
                          );
                        },
                      ),
                      SizedBox(height: 20.h),
                      Text(
                        'Mobile Phones',
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
                            'lib/brands/brand_images/headphones.png',
                            height: 130.h,
                            fit: BoxFit.cover,
                          ),
                        ),
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (_) => const TotalInventory(
                                collection: 'Head Phones',
                              ),
                            ),
                          );
                        },
                      ),
                      SizedBox(height: 20.h),
                      Text(
                        'Head Phones',
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
                          'lib/brands/brand_images/laptop.png',
                          height: 130.h,
                          fit: BoxFit.cover,
                        ),
                      ),
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (_) => const TotalInventory(
                              collection: 'Laptops',
                            ),
                          ),
                        );
                      },
                    ),
                    SizedBox(height: 20.h),
                    Text(
                      'Laptops',
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
