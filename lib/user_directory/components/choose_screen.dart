import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sales_alert_app/User_directory/screens/user_login_page.dart';
import 'package:sales_alert_app/brands/Screens/brand_login_page.dart';

import '../../Common_component/my_button.dart';

class ChooseScreen extends StatelessWidget {
  const ChooseScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(height: 170.h),
            Center(
              child: Text(
                "Are you a brand \n \t     \towner?",
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 30.sp,
                ),
              ),
            ),
            SizedBox(height: 90.h),
            MyButton(
              label: "Yes",
              onPress: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (_) => const BrandLoginPage(),
                  ),
                );
              },
            ),
            SizedBox(height: 40.h),
            MyButton(
              label: "No",
              onPress: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (_) => const UserLoginPage(),
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
