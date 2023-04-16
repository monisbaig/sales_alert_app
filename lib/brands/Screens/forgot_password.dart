import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../Common_component/my_button.dart';
import 'brand_login_page.dart';

class ForgotPassword extends StatelessWidget {
  const ForgotPassword({super.key});

  // sign user in method
  void recoverPass() {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(height: 150.h),
            Container(
              alignment: Alignment.topLeft,
              margin: EdgeInsets.only(left: 30.r),
              child: Text(
                'Forgot Password',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 40.sp,
                ),
              ),
            ),
            SizedBox(height: 80.h),
            Container(
              alignment: Alignment.topLeft,
              margin: EdgeInsets.only(left: 30.r),
              child: Text(
                  "Please, enter your email address. You will receive a link to create a new password via email.",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16.sp,
                  )),
            ),
            SizedBox(height: 20.h),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 25),
              child: TextField(
                decoration: InputDecoration(
                    contentPadding: EdgeInsets.only(
                      top: 10,
                      bottom: 20,
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white),
                    ),
                    fillColor: Colors.white,
                    filled: true,
                    hintText: 'Enter Email',
                    hintStyle: TextStyle(
                      color: Color(0xFFDB3022),
                    )),
              ),
            ),
            SizedBox(height: 60.h),
            MyButton(
              label: "Send",
              onPress: () {
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (_) => BrandLoginPage()));
              },
            ),
          ],
        ),
      ),
    );
  }
}
