import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../Common_component/my_button.dart';
import 'cart_screen.dart';

class FavouritesScreen extends StatelessWidget {
  List<String> pNames = [
    "Apple Watch -M2",
    "Ear Headphone",
    "White Tshirt",
    "Nike Shoe",
  ];

  List<String> pSizes = [
    "36",
    "M",
    "S",
    "40",
  ];

  FavouritesScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(top: 60, left: 15, right: 50),
          child: Column(
            children: [
              Align(
                child: Text(
                  "Favourites",
                  style: TextStyle(
                    fontSize: 22.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SizedBox(height: 20.h),
              Column(
                children: [
                  for (int i = 0; i < 4; i++)
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          margin: const EdgeInsets.symmetric(vertical: 2),
                          height: 139.h,
                          width: 325.w,
                          decoration: BoxDecoration(
                            color: const Color.fromARGB(255, 248, 248, 248),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Row(children: [
                            Container(
                              margin: const EdgeInsets.only(left: 8),
                              padding: const EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                color: Colors.red,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Image.asset(
                                "lib/User_directory/user_images/${pNames[i]}.png",
                                height: 70.h,
                                width: 70.w,
                              ),
                            ),
                            SizedBox(
                              width: MediaQuery.of(context).size.width / 1.8,
                              child: Padding(
                                padding: const EdgeInsets.only(
                                    left: 15, top: 20, bottom: 25),
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      pNames[i],
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 18.sp,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Row(
                                      children: [
                                        Text(
                                          "Size",
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 16.sp,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(width: 5.w),
                                    Row(
                                      children: [
                                        Text(
                                          pSizes[i],
                                          style: TextStyle(
                                            color: Colors.black54,
                                            fontSize: 16.sp,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          "Rs.90.55",
                                          style: TextStyle(
                                            color: Colors.redAccent,
                                            fontSize: 16.sp,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            )
                          ]),
                        )
                      ],
                    ),
                ],
              ),
              SizedBox(height: 30.h),
              MyButton(
                  label: 'Add to Cart',
                  onPress: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => CartScreen()));
                  })
            ],
          ),
        ),
      ),
    );
  }
}
