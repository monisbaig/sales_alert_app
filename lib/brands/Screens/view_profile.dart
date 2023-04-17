import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sales_alert_app/brands/auth/controller/brand_auth_controller.dart';
import 'package:sales_alert_app/brands/brands_components/get_data.dart';

import '../../Common_component/loader.dart';
import '../brands_components/brand_nav_bar.dart';
import '../brands_components/get_inventory_data.dart';
import '../brands_components/profile_menu.dart';
import 'view_orders.dart';
// import 'inventory/total_inventory.dart';

class ViewBrandProfile extends ConsumerStatefulWidget {
  const ViewBrandProfile({super.key});

  @override
  ConsumerState<ViewBrandProfile> createState() => _ViewBrandProfileState();
}

class _ViewBrandProfileState extends ConsumerState<ViewBrandProfile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
      ),
      drawer: const BrandNavBar(),
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.black,
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 30.h),
            Text(
              "Profile",
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 30.sp,
              ),
            ),
            SizedBox(height: 30.h),
            FutureBuilder(
              future: ref.read(brandAuthControllerProvider).getCategoryData(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Loader();
                }
                return Center(
                  child: snapshot.data != null
                      ? CircleAvatar(
                          backgroundImage: NetworkImage(snapshot.data!.logo),
                          radius: 70.sp,
                        )
                      : CircleAvatar(
                          backgroundImage: const AssetImage(
                              'lib/brands/brand_images/brand1.png'),
                          radius: 70.sp,
                        ),
                );
              },
            ),
            SizedBox(height: 35.h),
            ProfileMenu(
              label: "View Orders",
              onPress: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (_) => ViewOrders(),
                  ),
                );
              },
            ),
            SizedBox(height: 25.h),
            ProfileMenu(
              label: "Check Inventory",
              onPress: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (_) => const GetInventoryData(),
                  ),
                );
              },
            ),
            SizedBox(height: 25.h),
            ProfileMenu(
              label: "Add Products",
              onPress: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (_) => const GetData(),
                  ),
                );
              },
            ),
            // SizedBox(height: 25.h),
            // ProfileMenu(
            //   label: "Account Details",
            //   onPress: () {
            //     Navigator.of(context).push(
            //       MaterialPageRoute(
            //         builder: (_) => const AccountDetails(),
            //       ),
            //     );
            //   },
            // ),
          ],
        ),
      ),
    );
  }
}
