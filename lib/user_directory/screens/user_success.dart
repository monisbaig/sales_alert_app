import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../common_component/my_button.dart';
import 'bottom_navigator.dart';

class Success extends StatelessWidget {
  final String label;
  const Success({super.key, required this.label});

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
                    builder: (_) => BottomNavigator(),
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
