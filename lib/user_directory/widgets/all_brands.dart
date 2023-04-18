import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sales_alert_app/user_directory/auth/controller/user_auth_controller.dart';
import 'package:sales_alert_app/user_directory/screens/clothing_brand_screen.dart';
import 'package:sales_alert_app/user_directory/screens/electronics_brand_screen.dart';
import 'package:sales_alert_app/user_directory/screens/furniture_brand_screen.dart';

import '../../Common_component/loader.dart';

class AllBrands extends ConsumerWidget {
  const AllBrands({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: const EdgeInsets.only(left: 15, right: 15),
      child: FutureBuilder(
        future: ref.watch(userAuthControllerProvider).getBrandData(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Loader();
          }
          return GridView.builder(
            itemCount: snapshot.data?.length ?? 0,
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              childAspectRatio: 0.8,
              crossAxisCount: 2,
              crossAxisSpacing: 16,
            ),
            itemBuilder: (context, index) {
              var brandId = snapshot.data!.elementAt(index).uId;
              var brandName = snapshot.data!.elementAt(index).name;
              var brandImage = snapshot.data!.elementAt(index).logo;
              var brandCategory = snapshot.data!.elementAt(index).category;

              return GestureDetector(
                onTap: () {
                  if (brandCategory == 'Clothing') {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => ClothingBrandScreen(
                          brandId: brandId,
                          brandName: brandName,
                          brandImage: brandImage,
                          brandCategory: brandCategory,
                        ),
                      ),
                    );
                  }
                  if (brandCategory == 'Electronics') {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => ElectronicsBrandScreen(
                          brandId: brandId,
                          brandName: brandName,
                          brandImage: brandImage,
                          brandCategory: brandCategory,
                        ),
                      ),
                    );
                  }
                  if (brandCategory == 'Furniture') {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => FurnitureBrandScreen(
                          brandId: brandId,
                          brandName: brandName,
                          brandImage: brandImage,
                          brandCategory: brandCategory,
                        ),
                      ),
                    );
                  }
                },
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: const Color(0xFFD4ECF7),
                    boxShadow: const [
                      BoxShadow(
                        color: Colors.black26,
                        blurRadius: 4,
                        spreadRadius: 2,
                      )
                    ],
                  ),
                  child: Column(
                    children: [
                      Container(
                        height: 140.h,
                        decoration: BoxDecoration(
                          borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(15),
                            topRight: Radius.circular(15),
                          ),
                          image: DecorationImage(
                            image: NetworkImage(
                              snapshot.data?.elementAt(index).logo ?? '',
                            ),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      SizedBox(height: 15.h),
                      Text(
                        snapshot.data?.elementAt(index).name ?? '',
                        style: TextStyle(
                          fontSize: 18.sp,
                          color: Colors.black.withOpacity(0.8),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 16.h),
                      Text(
                        '${snapshot.data?.elementAt(index).category} Brand' ??
                            '',
                        style: const TextStyle(
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
