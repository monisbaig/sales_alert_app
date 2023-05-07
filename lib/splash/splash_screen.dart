// ignore_for_file: use_build_context_synchronously

import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:sales_alert_app/brands/screens/brand_choice.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../user_directory/components/choose_screen.dart';
import '../user_directory/screens/bottom_navigator.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  void timer() {
    Timer(
      const Duration(seconds: 3),
      () async {
        SharedPreferences prefs = await SharedPreferences.getInstance();

        if (prefs.getBool('userLoggedIn') == true &&
            FirebaseAuth.instance.currentUser != null) {
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
              builder: (context) => BottomNavigator(),
            ),
            (route) => false,
          );
        } else if (prefs.getBool('sellerLoggedIn') == true) {
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
              builder: (context) => const BrandChoice(),
            ),
            (route) => false,
          );
        } else {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => const ChooseScreen(),
            ),
          );
        }
      },
    );
  }

  @override
  void initState() {
    super.initState();
    timer();
  }

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
          // SplashButton(
          //   label: "Continue",
          //   onPress: () {
          //     Navigator.of(context).push(
          //       MaterialPageRoute(
          //         builder: (_) => const ChooseScreen(),
          //       ),
          //     );
          //   },
          // ),
        ],
      ),
    );
  }
}
