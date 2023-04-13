import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../Common_component/my_button.dart';
import '../../brands/Screens/brand_register.dart';
import '../auth/login_screen.dart';
import '../screens/bottom_navigation.dart';

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
                    MaterialPageRoute(builder: (_) => const RegisterScreen()));
              },
            ),
            SizedBox(height: 40.h),
            MyButton(
              label: "No",
              onPress: () {
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (_) => Screens()));
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (_) => const LoginScreen()));
              },
            ),
          ],
        ),
      ),
    );
  }
}
