import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sales_alert_app/user_directory/screens/select_product_one.dart';

class ProductOneCategory extends StatelessWidget {
  const ProductOneCategory({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 20.h),
              const Center(
                child: Text(
                  'Choose Category',
                  style: TextStyle(
                    fontSize: 30,
                    color: Colors.black,
                  ),
                ),
              ),
              SizedBox(height: 20.h),
              Padding(
                padding: EdgeInsets.only(left: 25.w),
                child: Text(
                  'Clothing :',
                  style: TextStyle(
                    fontSize: 25.sp,
                    color: Colors.black,
                  ),
                ),
              ),
              SizedBox(height: 10.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Column(
                    children: [
                      GestureDetector(
                        child: Container(
                          width: 100.w,
                          height: 100.w,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(26.r),
                            image: const DecorationImage(
                              image: AssetImage(
                                'lib/brands/brand_images/men.png',
                              ),
                              fit: BoxFit.fill,
                            ),
                          ),
                        ),
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) =>
                                  const SelectProductOne(collection: 'Men'),
                            ),
                          );
                        },
                      ),
                      SizedBox(height: 10.h),
                      Text(
                        'Men',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 16.sp,
                        ),
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      GestureDetector(
                        child: Container(
                          width: 100.w,
                          height: 100.w,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(26.r),
                            image: const DecorationImage(
                              image: AssetImage(
                                'lib/brands/brand_images/women.jpg',
                              ),
                              fit: BoxFit.fill,
                            ),
                          ),
                        ),
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) =>
                                  const SelectProductOne(collection: 'Women'),
                            ),
                          );
                        },
                      ),
                      SizedBox(height: 10.h),
                      Text(
                        'Women',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 16.sp,
                        ),
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      GestureDetector(
                        child: Container(
                          width: 100.w,
                          height: 100.w,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(26.r),
                            image: const DecorationImage(
                              image: AssetImage(
                                'lib/brands/brand_images/kids.jpg',
                              ),
                              fit: BoxFit.fill,
                            ),
                          ),
                        ),
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) =>
                                  const SelectProductOne(collection: 'Kids'),
                            ),
                          );
                        },
                      ),
                      SizedBox(height: 10.h),
                      Text(
                        'Kids',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 16.sp,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(height: 20.h),
              Padding(
                padding: EdgeInsets.only(left: 25.w),
                child: Text(
                  'Electronics :',
                  style: TextStyle(
                    fontSize: 25.sp,
                    color: Colors.black,
                  ),
                ),
              ),
              SizedBox(height: 10.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Column(
                    children: [
                      GestureDetector(
                        child: Container(
                          width: 100.w,
                          height: 100.w,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(26.r),
                            image: const DecorationImage(
                              image: AssetImage(
                                'lib/brands/brand_images/mobile.png',
                              ),
                              fit: BoxFit.fill,
                            ),
                          ),
                        ),
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => const SelectProductOne(
                                  collection: 'Mobile Phones'),
                            ),
                          );
                        },
                      ),
                      SizedBox(height: 10.h),
                      Text(
                        'Mobile Phones',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 16.sp,
                        ),
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      GestureDetector(
                        child: Container(
                          width: 100.w,
                          height: 100.w,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(26.r),
                            image: const DecorationImage(
                              image: AssetImage(
                                'lib/brands/brand_images/headphones.png',
                              ),
                              fit: BoxFit.fill,
                            ),
                          ),
                        ),
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => const SelectProductOne(
                                  collection: 'Head Phones'),
                            ),
                          );
                        },
                      ),
                      SizedBox(height: 10.h),
                      Text(
                        'Head Phones',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 16.sp,
                        ),
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      GestureDetector(
                        child: Container(
                          width: 100.w,
                          height: 100.w,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(26.r),
                            image: const DecorationImage(
                              image: AssetImage(
                                'lib/brands/brand_images/laptop.png',
                              ),
                              fit: BoxFit.fill,
                            ),
                          ),
                        ),
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) =>
                                  const SelectProductOne(collection: 'Laptops'),
                            ),
                          );
                        },
                      ),
                      SizedBox(height: 10.h),
                      Text(
                        'Laptops',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 16.sp,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(height: 20.h),
              Padding(
                padding: EdgeInsets.only(left: 25.w),
                child: Text(
                  'Furniture :',
                  style: TextStyle(
                    fontSize: 25.sp,
                    color: Colors.black,
                  ),
                ),
              ),
              SizedBox(height: 10.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Column(
                    children: [
                      GestureDetector(
                        child: Container(
                          width: 100.w,
                          height: 100.w,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(26.r),
                            image: const DecorationImage(
                              image: AssetImage(
                                'lib/brands/brand_images/sofa.png',
                              ),
                              fit: BoxFit.fill,
                            ),
                          ),
                        ),
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => const SelectProductOne(
                                  collection: 'Sofa Sets'),
                            ),
                          );
                        },
                      ),
                      SizedBox(height: 10.h),
                      Text(
                        'Sofa Sets',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 16.sp,
                        ),
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      GestureDetector(
                        child: Container(
                          width: 100.w,
                          height: 100.w,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(26.r),
                            image: const DecorationImage(
                              image: AssetImage(
                                'lib/brands/brand_images/bed.png',
                              ),
                              fit: BoxFit.fill,
                            ),
                          ),
                        ),
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => const SelectProductOne(
                                  collection: 'Bed Sets'),
                            ),
                          );
                        },
                      ),
                      SizedBox(height: 10.h),
                      Text(
                        'Bed Sets',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 16.sp,
                        ),
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      GestureDetector(
                        child: Container(
                          width: 100.w,
                          height: 100.w,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(26.r),
                            image: const DecorationImage(
                              image: AssetImage(
                                'lib/brands/brand_images/table.png',
                              ),
                              fit: BoxFit.fill,
                            ),
                          ),
                        ),
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => const SelectProductOne(
                                  collection: 'Table Sets'),
                            ),
                          );
                        },
                      ),
                      SizedBox(height: 10.h),
                      Text(
                        'Table Sets',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 16.sp,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
