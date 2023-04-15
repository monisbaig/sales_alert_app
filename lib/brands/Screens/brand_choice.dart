import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sales_alert_app/brands/brands_components/get_data.dart';

import '../brands_components/brand_button.dart';
import '../brands_components/brand_nav_bar.dart';
import 'view_profile.dart';

class BrandChoice extends StatefulWidget {
  const BrandChoice({super.key});

  @override
  State<BrandChoice> createState() => _BrandChoiceState();
}

class _BrandChoiceState extends State<BrandChoice> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
      ),
      drawer: const BrandNavBar(),
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(height: 50.h),
            Center(
              child: Image.asset(
                'lib/brands/brand_images/store.png',
                height: 210.h,
              ),
            ),
            SizedBox(height: 10.h),
            BrandButton(
                label: "Add details",
                onPress: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (_) => const GetData(),
                    ),
                  );
                }),
            SizedBox(height: 10.h),
            CircleAvatar(
              radius: 85.sp,
              backgroundImage: const AssetImage(
                'lib/brands/brand_images/profile.png',
              ),
            ),
            BrandButton(
              label: "View Profile",
              onPress: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (_) => const ViewBrandProfile(),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
