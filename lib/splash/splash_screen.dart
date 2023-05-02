import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';

import '../user_directory/components/choose_screen.dart';
import 'components/splash_content.dart';

class Splash extends StatefulWidget {
  const Splash({Key? key}) : super(key: key);

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          SizedBox(height: 180.h),
          Lottie.asset(
            'assets/images/splash.json',
            width: 220.w,
            fit: BoxFit.contain,
          ),
          SizedBox(height: 90.h),
          Center(
            child: Text(
              "Sales Alert",
              style: GoogleFonts.pacifico(
                textStyle: TextStyle(
                  fontSize: 45.sp,
                  color: const Color(0xFFDB3022),
                ),
              ),
            ),
          ),
          SizedBox(height: 100.h),
          SplashButton(
            label: "Continue",
            onPress: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (_) => const ChooseScreen(),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
