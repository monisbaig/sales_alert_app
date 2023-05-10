import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sales_alert_app/user_directory/screens/all_product_category.dart';
import 'package:sales_alert_app/user_directory/screens/search_product_screen.dart';
import 'package:sales_alert_app/user_directory/widgets/user_nav_bar.dart';

import '../auth/controller/user_notification_controller.dart';
import '../widgets/all_brands.dart';
import '../widgets/custom_categories.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    requestNotificationPermission();
    firebaseMessagingInit();
    setupInteractMessage();
  }

  void requestNotificationPermission() {
    ref
        .read(userNotificationControllerProvider)
        .requestNotificationPermission();
  }

  void firebaseMessagingInit() {
    ref.read(userNotificationControllerProvider).firebaseMessagingInit(context);
  }

  void setupInteractMessage() {
    ref.read(userNotificationControllerProvider).setupInteractMessage(context);
  }

  @override
  Widget build(BuildContext context) {
    List<Color> colour = [
      const Color.fromARGB(255, 246, 111, 58),
      const Color.fromARGB(255, 36, 131, 233),
      const Color.fromARGB(255, 63, 208, 143),
    ];
    var imageList = [
      "lib/user_directory/user_images/slide1.png",
      "lib/user_directory/user_images/slide3.png",
      "lib/user_directory/user_images/slide3.png",
    ];
    List iconImageList = [
      "lib/user_directory/user_images/icon1.png",
      "lib/user_directory/user_images/headphones.png",
      "lib/user_directory/user_images/icon3.png",
      "lib/user_directory/user_images/icon4.png",
      "lib/user_directory/user_images/armchair.png",
      "lib/user_directory/user_images/laptop.png",
      "lib/user_directory/user_images/double-bed.png",
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
                      child: GestureDetector(
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (_) => const SearchProductScreen(),
                            ),
                          );
                        },
                        child: const Icon(
                          CupertinoIcons.search,
                          size: 28,
                        ),
                      ),
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
                          color: colour[i],
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
                                    "Summer Sale Collection",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 22.sp,
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
                child: Text(
                  "All Product Categories",
                  style: TextStyle(
                    fontSize: 18.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SizedBox(height: 20.h),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: Row(
                    children: [
                      CustomCategories(
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => const AllProductCategory(
                                category: 'Shirts',
                              ),
                            ),
                          );
                        },
                        iconImages: iconImageList[0],
                      ),
                      CustomCategories(
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => const AllProductCategory(
                                category: 'Head Phones',
                              ),
                            ),
                          );
                        },
                        iconImages: iconImageList[1],
                      ),
                      CustomCategories(
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => const AllProductCategory(
                                category: 'Mobile Phones',
                              ),
                            ),
                          );
                        },
                        iconImages: iconImageList[2],
                      ),
                      CustomCategories(
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => const AllProductCategory(
                                category: 'Shoes',
                              ),
                            ),
                          );
                        },
                        iconImages: iconImageList[3],
                      ),
                      CustomCategories(
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => const AllProductCategory(
                                category: 'Sofa Set',
                              ),
                            ),
                          );
                        },
                        iconImages: iconImageList[4],
                      ),
                      CustomCategories(
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => const AllProductCategory(
                                category: 'Laptops',
                              ),
                            ),
                          );
                        },
                        iconImages: iconImageList[5],
                      ),
                      CustomCategories(
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => const AllProductCategory(
                                category: 'Bed Set',
                              ),
                            ),
                          );
                        },
                        iconImages: iconImageList[6],
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 20.h),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Text(
                  "All Brands",
                  style: TextStyle(
                    fontSize: 18.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SizedBox(height: 20.h),
              const AllBrands(),
              SizedBox(height: 20.h),
            ],
          ),
        ),
      ),
    );
  }
}
