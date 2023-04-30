import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sales_alert_app/user_directory/auth/controller/user_auth_controller.dart';

import '../../common_component/loader.dart';

class FavouritesScreen extends ConsumerStatefulWidget {
  const FavouritesScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<FavouritesScreen> createState() => _FavouritesScreenState();
}

class _FavouritesScreenState extends ConsumerState<FavouritesScreen> {
  int? addedToCartIndex;

  int? orderQuantity;

  void cartDataToFirebase(
    context,
    productId,
    productName,
    productImage,
    productPrice,
    productColor,
    productSize,
    orderQuantity,
    brandId,
  ) {
    ref.watch(userAuthControllerProvider).cartDataToFirebase(
          context,
          productId,
          productName,
          productImage,
          productPrice,
          productColor,
          productSize,
          orderQuantity,
          brandId,
        );
    setState(() {});
  }

  void deleteMyFavoritesData(String productId) {
    ref.watch(userAuthControllerProvider).deleteMyFavoritesData(productId);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream:
          ref.watch(userAuthControllerProvider).getFavoritesData().asStream(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Loader();
        }
        return snapshot.data!.isEmpty
            ? Center(
                heightFactor: 2.5,
                child: Image.asset(
                  'lib/user_directory/user_images/wish-list.png',
                  width: 300.w,
                  height: 300.h,
                ),
              )
            : Column(
                children: [
                  SizedBox(height: 40.h),
                  Align(
                    child: Text(
                      "Favourites",
                      style: TextStyle(
                        fontSize: 22.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  SizedBox(height: 5.h),
                  SizedBox(
                    height: MediaQuery.of(context).size.height / 1.6,
                    child: ListView.builder(
                      shrinkWrap: true,
                      physics: const ScrollPhysics(),
                      itemCount: snapshot.data!.length,
                      itemBuilder: (context, index) {
                        var productData = snapshot.data!.elementAt(index);

                        return Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              margin: const EdgeInsets.symmetric(vertical: 2),
                              height: 170.h,
                              width: MediaQuery.of(context).size.width * 0.9,
                              decoration: BoxDecoration(
                                color: Colors.black12,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Container(
                                    width: 110.w,
                                    height: 120.h,
                                    padding: const EdgeInsets.all(20),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      image: DecorationImage(
                                        image: NetworkImage(
                                            productData.productImage),
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    child: Padding(
                                      padding: const EdgeInsets.only(
                                          left: 15, top: 20, bottom: 25),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            productData.productName,
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
                                              SizedBox(width: 133.w),
                                              GestureDetector(
                                                onTap: () =>
                                                    deleteMyFavoritesData(
                                                        productData.productId),
                                                child: const Icon(
                                                  Icons.delete,
                                                  color: Colors.redAccent,
                                                ),
                                              ),
                                            ],
                                          ),
                                          SizedBox(width: 5.w),
                                          Row(
                                            children: [
                                              Text(
                                                productData.productSize,
                                                style: TextStyle(
                                                  color: Colors.black54,
                                                  fontSize: 16.sp,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            ],
                                          ),
                                          Row(
                                            children: [
                                              Text(
                                                productData.totalOrderPrice,
                                                style: TextStyle(
                                                  color: Colors.redAccent,
                                                  fontSize: 16.sp,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                              SizedBox(width: 65.w),
                                              OutlinedButton(
                                                style: OutlinedButton.styleFrom(
                                                  backgroundColor:
                                                      addedToCartIndex == index
                                                          ? Colors.green
                                                          : Colors.redAccent,
                                                ),
                                                onPressed: () {
                                                  addedToCartIndex = index;
                                                  orderQuantity = 1;
                                                  cartDataToFirebase(
                                                    context,
                                                    productData.productId,
                                                    productData.productName,
                                                    productData.productImage,
                                                    productData.productPrice,
                                                    productData.productColor,
                                                    productData.productSize,
                                                    orderQuantity,
                                                    productData.brandId,
                                                  );
                                                  Future.delayed(
                                                      const Duration(
                                                          seconds: 3), () {
                                                    deleteMyFavoritesData(
                                                        productData.productId);
                                                  });
                                                },
                                                child: Text(
                                                  addedToCartIndex == index
                                                      ? "Added      "
                                                      : "Add to cart",
                                                  textAlign: TextAlign.center,
                                                  style: const TextStyle(
                                                    color: Colors.white,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          )
                                        ],
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ],
                        );
                      },
                    ),
                  ),
                ],
              );
      },
    );
  }
}
