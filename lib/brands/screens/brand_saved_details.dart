import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sales_alert_app/brands/auth/controller/brand_auth_controller.dart';

import '../../common_component/loader.dart';

class BrandSavedDetails extends ConsumerStatefulWidget {
  const BrandSavedDetails({super.key});

  @override
  ConsumerState<BrandSavedDetails> createState() => _BrandDetailsState();
}

class _BrandDetailsState extends ConsumerState<BrandSavedDetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      resizeToAvoidBottomInset: false,
      body: FutureBuilder(
          future: ref.watch(brandAuthControllerProvider).getCategoryData(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Loader();
            }
            var brandName = snapshot.data?.name ?? '';
            var brandCategory = snapshot.data?.category ?? '';
            var brandImage = snapshot.data?.logo ?? '';

            return SafeArea(
              child: Column(
                children: [
                  SizedBox(height: 40.h),
                  Text(
                    "Brand Details",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 35.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 40.h),
                  Text(
                    "Your Store Details.",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18.sp,
                    ),
                  ),
                  SizedBox(height: 40.h),
                  CircleAvatar(
                    backgroundImage: NetworkImage(brandImage),
                    radius: 60,
                  ),
                  SizedBox(height: 20.h),
                  Text(
                    "Brand Logo",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18.sp,
                    ),
                  ),
                  SizedBox(height: 30.h),
                  Padding(
                    padding: EdgeInsets.only(right: 260.r),
                    child: Text(
                      "Brand Name",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 15.sp,
                      ),
                    ),
                  ),
                  SizedBox(height: 20.h),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25),
                    child: Container(
                      padding: const EdgeInsets.only(left: 5),
                      height: 60.h,
                      alignment: Alignment.centerLeft,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Text(
                        brandName,
                        style: const TextStyle(
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 20.0.h),
                  Padding(
                    padding: EdgeInsets.only(right: 240.r),
                    child: Text(
                      "Brand Category",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 15.sp,
                      ),
                    ),
                  ),
                  SizedBox(height: 20.h),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25),
                    child: Container(
                      padding: const EdgeInsets.only(left: 5),
                      height: 60.h,
                      alignment: Alignment.centerLeft,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Text(
                        brandCategory,
                        style: const TextStyle(
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            );
          }),
    );
  }
}
