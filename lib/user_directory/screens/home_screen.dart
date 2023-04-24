import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sales_alert_app/user_directory/widgets/user_nav_bar.dart';

import '../widgets/all_brands.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    List<Color> Clrs = [
      const Color.fromARGB(255, 246, 111, 58),
      const Color.fromARGB(255, 36, 131, 233),
      const Color.fromARGB(255, 63, 208, 143),
    ];
    var imageList = [
      "lib/User_directory/user_images/slide1.png",
      "lib/User_directory/user_images/slide3.png",
      "lib/User_directory/user_images/slide3.png",
    ];
    List iconImageList = [
      "lib/User_directory/user_images/icon1.png",
      "lib/User_directory/user_images/icon2.png",
      "lib/User_directory/user_images/icon3.png",
      "lib/User_directory/user_images/icon4.png",
      "lib/User_directory/user_images/icon5.png",
      "lib/User_directory/user_images/icon6.png",
      "lib/User_directory/user_images/icon7.png",
    ];

    return Scaffold(
      key: _scaffoldKey,
      drawer: const UserNavBar(),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 15, left: 15, right: 15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(10.0),
                      decoration: BoxDecoration(
                        color: Colors.redAccent,
                        borderRadius: BorderRadius.circular(10.r),
                        boxShadow: const [
                          BoxShadow(
                            color: Colors.black26,
                            blurRadius: 4,
                            spreadRadius: 2,
                          ),
                        ],
                      ),
                      child: GestureDetector(
                        child: const Icon(Icons.menu, size: 28),
                        onTap: () {
                          return _scaffoldKey.currentState!.openDrawer();
                        },
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.all(10.0.r),
                      decoration: BoxDecoration(
                        color: Colors.redAccent,
                        borderRadius: BorderRadius.circular(10.r),
                        boxShadow: const [
                          BoxShadow(
                            color: Colors.black26,
                            blurRadius: 4,
                            spreadRadius: 2,
                          ),
                        ],
                      ),
                      child: const Icon(CupertinoIcons.search, size: 28),
                    ),
                  ],
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 25, horizontal: 15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Welcome",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 15.sp,
                        fontWeight: FontWeight.bold,
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                    Text(
                      "All you need is here!",
                      style: TextStyle(
                        color: Colors.black45,
                        fontSize: 13.sp,
                        fontWeight: FontWeight.bold,
                        fontStyle: FontStyle.italic,
                      ),
                    )
                  ],
                ),
              ),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.only(left: 15),
                child: Row(
                  children: [
                    for (int i = 0; i < imageList.length; i++)
                      Container(
                        margin: const EdgeInsets.only(right: 10),
                        padding: const EdgeInsets.only(left: 10),
                        width: MediaQuery.of(context).size.width / 1.5,
                        height: MediaQuery.of(context).size.height / 5.5,
                        decoration: BoxDecoration(
                          color: Clrs[i],
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Winter Sale Collection",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 25.sp,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Container(
                                    width: 90.w,
                                    padding: EdgeInsets.all(10.r),
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(20.r),
                                    ),
                                    child: const Center(
                                      child: Text(
                                        "Shop Now",
                                        style: TextStyle(
                                          color: Colors.redAccent,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                            Image.asset(
                              imageList[i],
                              height: 180.h,
                              width: 110.w,
                            )
                          ],
                        ),
                      ),
                  ],
                ),
              ),
              SizedBox(height: 20.h),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "All Brands",
                      style: TextStyle(
                        fontSize: 18.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    // const Text(
                    //   "See All",
                    //   style: TextStyle(
                    //     color: Colors.black54,
                    //   ),
                    // ),
                  ],
                ),
              ),
              // SizedBox(height: 20.h),
              // SingleChildScrollView(
              //   scrollDirection: Axis.horizontal,
              //   child: Padding(
              //     padding: const EdgeInsets.only(left: 10),
              //     child: Row(
              //       children: [
              //         CustomCategories(
              //           onTap: () {
              //             Navigator.of(context).push(
              //               MaterialPageRoute(
              //                 builder: (context) =>
              //                     const ClothingCategoryScreen(collection: 'Men'),
              //               ),
              //             );
              //           },
              //           iconImages: iconImageList[0],
              //         ),
              //         CustomCategories(
              //           onTap: () {},
              //           iconImages: iconImageList[1],
              //         ),
              //         CustomCategories(
              //           onTap: () {},
              //           iconImages: iconImageList[2],
              //         ),
              //         CustomCategories(
              //           onTap: () {},
              //           iconImages: iconImageList[3],
              //         ),
              //         CustomCategories(
              //           onTap: () {},
              //           iconImages: iconImageList[4],
              //         ),
              //         CustomCategories(
              //           onTap: () {},
              //           iconImages: iconImageList[5],
              //         ),
              //         CustomCategories(
              //           onTap: () {},
              //           iconImages: iconImageList[6],
              //         ),
              //       ],
              //     ),
              //   ),
              // ),
              SizedBox(height: 20.h),
              const AllBrands(),
            ],
          ),
        ),
      ),
    );
  }
}
