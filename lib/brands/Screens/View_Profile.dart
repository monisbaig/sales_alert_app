import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../brands_components/NavBar.dart';
import '../brands_components/Profile_Menu.dart';
import 'Account_Details.dart';
import 'View_Orders.dart';
import 'clothing/clothing_categories.dart';
import 'inventory/inventory.dart';
// import 'inventory/inventory.dart';

class ViewBrandProfile extends StatefulWidget {
  String id;
  ViewBrandProfile({Key? key, required this.id}) : super(key: key);

  @override
  State<ViewBrandProfile> createState() => _ViewBrandProfileState();
}

class _ViewBrandProfileState extends State<ViewBrandProfile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
      ),
      drawer: NavBar(),
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.black,
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 90.h),
            Text(
              "Profile",
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 30.sp,
              ),
            ),
            SizedBox(height: 30.h),
            SizedBox(
              height: 90.h,
              width: 90.w,
              child: Center(
                child: Stack(
                  fit: StackFit.expand,
                  children: [
                    const CircleAvatar(
                      backgroundImage: AssetImage(
                          "lib/Brand_directory/Brand_images/brand1.png"),
                    ),
                    SizedBox(height: 20.h),
                  ],
                ),
              ),
            ),
            SizedBox(height: 35.h),
            ProfileMenu(
              label: "View Orders",
              onPress: () {
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (_) => ViewOrders()));
              },
            ),
            SizedBox(height: 25.h),
            ProfileMenu(
              label: "Check Inventory",
              onPress: () {
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (_) => const inventory()));
              },
            ),
            SizedBox(height: 25.h),
            ProfileMenu(
              label: "Add Products",
              onPress: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (_) => const ClothingCategories()));
              },
            ),
            SizedBox(height: 25.h),
            ProfileMenu(
              label: "Account Details",
              onPress: () {
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (_) => const AccountDetails()));
              },
            ),
          ],
        ),
      ),
    );
  }
}
