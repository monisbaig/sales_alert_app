import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'item_details.dart';

class women extends StatelessWidget {
  women({super.key});


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Column(
            children: [

              Stack(
                  children:
                  [
                    Image.asset('lib/Brand_directory/Brand_images/women_clothing.jpg',),
                    Positioned.fill(
                      child:Align(
                        alignment: Alignment.center,
                        child: Text("Women's Items ",
                          style:
                          TextStyle(
                            color: Colors.white,
                            fontSize: 30.sp,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),

                  ]
              ),
              SizedBox(height: 20.h),
              Container(
                alignment:Alignment.topLeft,
                //margin: EdgeInsets.only(left: 15.w),
                child:  Text("Choose Category",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20.sp,
                    )
                ),
              ),
              SizedBox(height: 20.h),
              const Divider(
                thickness: 0.5,
                color: Color(0xFFD7B4B4),
              ),
              SizedBox(height: 10.h),
              Container(
                alignment:Alignment.topLeft,
                child: GestureDetector(
                child:  GestureDetector(
                  child: Text("Kurti",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20.sp,
                      )
                  ),
                  onTap: ()
                  {
                    Navigator.of(context).push(
                        MaterialPageRoute(builder: (_) => const add_item())
                    );
                  },
                ),
              ),
              ),
              SizedBox(height: 10.h),
              const Divider(
                thickness: 0.5,
                color: Color(0xFFD7B4B4),
              ),
              SizedBox(height: 10.h),
              Container(
                alignment:Alignment.topLeft,
                //margin: EdgeInsets.only(left: 15.w),
                child:  GestureDetector(
                  child: Text("Skirts",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20.sp,
                      )
                  ),
                  onTap: ()
                  {
                    Navigator.of(context).push(
                        MaterialPageRoute(builder: (_) => add_item())
                    );
                  },
                ),
              ),
              SizedBox(height: 10.h),
              const Divider(
                thickness: 0.5,
                color: Color(0xFFD7B4B4),
              ),
              SizedBox(height: 10.h),
              Container(
                alignment:Alignment.topLeft,
                //margin: EdgeInsets.only(left: 15.w),
                child:  GestureDetector(
                  child: Text("Trousers",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20.sp,
                      )
                  ),
                  onTap: ()
                  {
                    Navigator.of(context).push(
                        MaterialPageRoute(builder: (_) => add_item())
                    );
                  },
                ),
              ),
              SizedBox(height: 10.h),
              const Divider(
                thickness: 0.5,
                color: Color(0xFFD7B4B4),
              ),
              SizedBox(height: 10.h),
              Container(
                alignment:Alignment.topLeft,
                //margin: EdgeInsets.only(left: 15.w),
                child:  GestureDetector(
                  child: Text("Shoes",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20.sp,
                      )
                  ),
                  onTap: ()
                  {
                    Navigator.of(context).push(
                        MaterialPageRoute(builder: (_) => add_item())
                    );
                  },
                ),
              ),
              SizedBox(height: 10.h),
              const Divider(
                thickness: 0.5,
                color: Color(0xFFD7B4B4),
              ),
              SizedBox(height: 10.h),
              Container(
                alignment:Alignment.topLeft,
                //margin: EdgeInsets.only(left: 15.w),
                child:  GestureDetector(
                  child: Text("Accessories",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20.sp,
                      )
                  ),
                  onTap: ()
                  {
                    Navigator.of(context).push(
                        MaterialPageRoute(builder: (_) => add_item())
                    );
                  },
                ),
              ),
              SizedBox(height: 10.h),
              const Divider(
                thickness: 0.5,
                color: Color(0xFFD7B4B4),
              ),
            ]
        ),
      ),
    );
  }
}