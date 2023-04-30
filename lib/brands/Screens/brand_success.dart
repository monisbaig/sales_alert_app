import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sales_alert_app/brands/Screens/brand_choice.dart';

import '../../Common_component/my_button.dart';

class BrandSuccess extends StatelessWidget {
  final String label;
  const BrandSuccess({super.key, required this.label});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(height: 50.h),
            Center(
              child: Image.asset('lib/common_images/sucess.png'),
            ),
            Center(
              child: Text(
                'Success! ',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 50.sp,
                ),
              ),
            ),
            SizedBox(height: 70.h),
            Center(
              child: Text(
                label,
                style: TextStyle(
                  color: Colors.white,
                  fontStyle: FontStyle.italic,
                  fontSize: 20.sp,
                ),
              ),
            ),
            SizedBox(height: 80.h),
            MyButton(
              label: "Main Menu",
              onPress: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (_) => const BrandChoice(),
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
