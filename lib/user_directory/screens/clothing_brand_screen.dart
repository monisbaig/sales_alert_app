import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sales_alert_app/user_directory/screens/all_brand_collections.dart';

import '../auth/controller/user_auth_controller.dart';

class ClothingBrandScreen extends ConsumerStatefulWidget {
  final String brandId;
  final String brandName;
  final String brandImage;
  final String brandCategory;

  const ClothingBrandScreen({
    super.key,
    required this.brandId,
    required this.brandName,
    required this.brandImage,
    required this.brandCategory,
  });

  @override
  ConsumerState<ClothingBrandScreen> createState() =>
      _ClothingBrandScreenState();
}

class _ClothingBrandScreenState extends ConsumerState<ClothingBrandScreen> {
  void followBrand() {
    ref.watch(userAuthControllerProvider).followBrand(
          widget.brandId,
          widget.brandName,
        );
  }

  void unFollowBrand() {
    ref.watch(userAuthControllerProvider).unFollowBrand(
          widget.brandId,
        );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                children: [
                  Container(
                    height: MediaQuery.of(context).size.height / 2,
                    decoration: BoxDecoration(
                      color: const Color(0xFFD4ECF7),
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(30.r),
                        bottomRight: Radius.circular(30.r),
                      ),
                      image: DecorationImage(
                        image: NetworkImage(widget.brandImage),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 15, top: 20),
                    child: InkWell(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: const Icon(
                        Icons.arrow_back_ios_new,
                        color: Colors.white,
                        size: 30,
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 80,
                    left: 0,
                    right: 0,
                    child: Text(
                      textAlign: TextAlign.center,
                      widget.brandName,
                      style: const TextStyle(
                        fontSize: 45,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  StreamBuilder(
                    stream: ref
                        .watch(userAuthControllerProvider)
                        .getFollowingData(widget.brandId),
                    builder: (context, snapshot) {
                      var following = snapshot.data;
                      return Positioned(
                        bottom: 30,
                        left: 120,
                        right: 120,
                        child: OutlinedButton(
                          style: OutlinedButton.styleFrom(
                            backgroundColor: Colors.redAccent,
                          ),
                          onPressed:
                              following != null ? unFollowBrand : followBrand,
                          child: Text(
                            following != null ? "Following" : 'Follow Us',
                            style: const TextStyle(
                              color: Colors.white,
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                  const Positioned(
                    bottom: 12,
                    left: 0,
                    right: 0,
                    child: Text(
                      textAlign: TextAlign.center,
                      'Follow us for continuous updates',
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20.h),
              const Center(
                child: Text(
                  'Choose Category',
                  style: TextStyle(
                    fontSize: 30,
                    color: Colors.black,
                  ),
                ),
              ),
              SizedBox(height: 20.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Column(
                    children: [
                      GestureDetector(
                        child: Container(
                          width: 100.w,
                          height: 100.w,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(26.r),
                            image: const DecorationImage(
                              image: AssetImage(
                                'lib/brands/brand_images/men.png',
                              ),
                              fit: BoxFit.fill,
                            ),
                          ),
                        ),
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (_) => AllBrandCollections(
                                brandId: widget.brandId,
                                brandName: widget.brandName,
                                brandImage: widget.brandImage,
                                brandCategory: widget.brandCategory,
                                brandCollection: 'Men',
                              ),
                            ),
                          );
                        },
                      ),
                      SizedBox(height: 10.h),
                      Text(
                        'Men',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 16.sp,
                        ),
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      GestureDetector(
                        child: Container(
                          width: 100.w,
                          height: 100.w,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(26.r),
                            image: const DecorationImage(
                              image: AssetImage(
                                'lib/brands/brand_images/women.jpg',
                              ),
                              fit: BoxFit.fill,
                            ),
                          ),
                        ),
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (_) => AllBrandCollections(
                                brandId: widget.brandId,
                                brandName: widget.brandName,
                                brandImage: widget.brandImage,
                                brandCategory: widget.brandCategory,
                                brandCollection: 'Women',
                              ),
                            ),
                          );
                        },
                      ),
                      SizedBox(height: 10.h),
                      Text(
                        'Women',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 16.sp,
                        ),
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      GestureDetector(
                        child: Container(
                          width: 100.w,
                          height: 100.w,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(26.r),
                            image: const DecorationImage(
                              image: AssetImage(
                                'lib/brands/brand_images/kids.jpg',
                              ),
                              fit: BoxFit.fill,
                            ),
                          ),
                        ),
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (_) => AllBrandCollections(
                                brandId: widget.brandId,
                                brandName: widget.brandName,
                                brandImage: widget.brandImage,
                                brandCategory: widget.brandCategory,
                                brandCollection: 'Kids',
                              ),
                            ),
                          );
                        },
                      ),
                      SizedBox(height: 10.h),
                      Text(
                        'Kids',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 16.sp,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
