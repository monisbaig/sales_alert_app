

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'furniture_items.dart';

class furniture extends StatelessWidget {
  furniture({super.key});


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(height: 100.h),
            Center(
              child: Text('Choose a ',
                style:
                TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 40.sp,
                ),
              ),
            ),
            Center(
              child: Text('Subcategory ',
                style:
                TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 40.sp,
                ),
              ),
            ),
            SizedBox(height: 20.h),
            Center(
              child: Text('Furniture',
                style:
                TextStyle(
                  color: Colors.white,
                  fontSize: 16.sp,
                ),
              ),
            ),

            SizedBox(height: 80.h),
            Center(
              child: Column(
                //mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    children:[
                      SizedBox(width: 25.w),
                      GestureDetector(
                        child:ClipRRect(
                          child: Image.asset('lib/Brand_directory/Brand_images/sofa.png',
                            //width:50.w,
                            height: 150.h,
                            fit:BoxFit.cover,

                          ),
                        ),
                        onTap: ()
                        {
                          Navigator.of(context).push(
                              MaterialPageRoute(builder: (_) => f_item())
                          );
                        },
                      ),
                      SizedBox(width: 30.w),
                      GestureDetector(
                        child: ClipRRect(
                          child: Image.asset('lib/Brand_directory/Brand_images/bed.png',
                            // width:75.w,
                            height: 150.h,
                            fit:BoxFit.cover,
                          ),
                        ),
                        onTap: ()
                        {
                          Navigator.of(context).push(
                              MaterialPageRoute(builder: (_) => f_item())
                          );
                        },
                      ),
                    ],
                  ),
                  SizedBox(height: 10.h),
                  Row(
                    children:[
                      SizedBox(width: 65.w),
                      Text('Sofa set ',
                        style:
                        TextStyle(
                          color: Colors.white,
                          fontSize: 16.sp,
                        ),
                      ),
                      SizedBox(width: 145.w),
                      Text('Bed set ',
                        style:
                        TextStyle(
                          color: Colors.white,
                          fontSize: 16.sp,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 50.h),
                  Row(
                    children:[
                      SizedBox(width: 25.w),
                      GestureDetector(
                        child:ClipRRect(
                          child: Image.asset('lib/Brand_directory/Brand_images/table.png',
                            //width:50.w,
                            height: 150.h,
                            fit:BoxFit.cover,

                          ),
                        ),
                        onTap: ()
                        {
                          Navigator.of(context).push(
                              MaterialPageRoute(builder: (_) => f_item())
                          );
                        },
                      ),
                      SizedBox(width: 30.w),
                      GestureDetector(
                        child: ClipRRect(
                          child: Image.asset('lib/Brand_directory/Brand_images/other.png',
                            // width:75.w,
                            height: 150.h,
                            fit:BoxFit.cover,
                          ),
                        ),
                        onTap: ()
                        {
                          Navigator.of(context).push(
                              MaterialPageRoute(builder: (_) => f_item())
                          );
                        },
                      ),
                    ],
                  ),
                  SizedBox(height: 10.h),
                  Row(
                    children:[
                      SizedBox(width: 65.w),
                      Text('Table set ',
                        style:
                        TextStyle(
                          color: Colors.white,
                          fontSize: 16.sp,
                        ),
                      ),
                      SizedBox(width: 145.w),
                      Text('Other ',
                        style:
                        TextStyle(
                          color: Colors.white,
                          fontSize: 16.sp,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(height: 50.h),
          ],
        ),
      ),
    );
  }
}