import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AboutUs extends StatelessWidget {
  const AboutUs({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const Text(
                'Flutter Developers',
                style: TextStyle(
                    fontFamily: 'SourceSansPro',
                    letterSpacing: 2.5,
                    color: Color(0xFFDB3022),
                    fontSize: 27,
                    fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 20,
                width: 150,
                child: Divider(
                  color: Color(0xFFDB3022),
                ),
              ),
              SizedBox(height: 35.h),
              Card(
                color: const Color(0xFFDB3022),
                margin:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 25),
                child: ListTile(
                  leading: const Icon(
                    Icons.phone,
                    color: Colors.white,
                  ),
                  title: Text(
                    '+92-331-5042122',
                    style: TextStyle(
                      fontFamily: 'SourceSansPro',
                      color: Colors.white,
                      fontSize: 18.sp,
                    ),
                  ),
                ),
              ),
              Card(
                color: const Color(0xFFDB3022),
                margin: const EdgeInsets.symmetric(vertical: 2, horizontal: 25),
                child: ListTile(
                  leading: const Icon(
                    Icons.email,
                    color: Colors.white,
                  ),
                  title: Text(
                    'muhamadullah682@gmail.com',
                    style: TextStyle(
                      fontFamily: 'SourceSansPro',
                      color: Colors.white,
                      fontSize: 18.sp,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 35.h),
              Card(
                color: const Color(0xFFDB3022),
                margin:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 25),
                child: ListTile(
                  leading: const Icon(
                    Icons.phone,
                    color: Colors.white,
                  ),
                  title: Text(
                    '+92-335-5591400',
                    style: TextStyle(
                      fontFamily: 'SourceSansPro',
                      color: Colors.white,
                      fontSize: 18.sp,
                    ),
                  ),
                ),
              ),
              Card(
                color: const Color(0xFFDB3022),
                margin: const EdgeInsets.symmetric(vertical: 2, horizontal: 25),
                child: ListTile(
                  leading: const Icon(
                    Icons.email,
                    color: Colors.white,
                  ),
                  title: Text(
                    'harrisimran78@gmail.com',
                    style: TextStyle(
                      fontFamily: 'SourceSansPro',
                      color: Colors.white,
                      fontSize: 18.sp,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 55.h),
            ],
          ),
        ),
      ),
    );
  }
}
