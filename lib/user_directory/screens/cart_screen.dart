import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sales_alert_app/user_directory/auth/controller/user_auth_controller.dart';

import 'buy_now.dart';

class CartScreen extends ConsumerStatefulWidget {
  const CartScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends ConsumerState<CartScreen> {
  void deleteMyCartData(String productId) {
    ref.watch(userAuthControllerProvider).deleteMyCartData(productId);
    setState(() {});
  }

  void updateCartDataToFirebase(
    context,
    productId,
    productPrice,
    orderQuantity,
  ) {
    ref.watch(userAuthControllerProvider).updateCartDataToFirebase(
          context,
          productId,
          productPrice,
          orderQuantity,
        );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: 40.h),
        Align(
          child: Text(
            "My Cart",
            style: TextStyle(
              fontSize: 22.sp,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        SizedBox(height: 5.h),
        FutureBuilder(
          future: ref.watch(userAuthControllerProvider).getMyCartData(),
          builder: (context, snapshot) {
            return SizedBox(
              height: MediaQuery.of(context).size.height / 1.6,
              child: ListView.builder(
                shrinkWrap: true,
                physics: const ScrollPhysics(),
                itemCount: snapshot.data?.length ?? 0,
                itemBuilder: (context, index) {
                  var productData = snapshot.data?.elementAt(index);
                  var orderCounter = int.parse(productData!.orderQuantity);

                  return Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        margin: const EdgeInsets.symmetric(vertical: 2),
                        height: 150.h,
                        width: MediaQuery.of(context).size.width * 0.9,
                        decoration: BoxDecoration(
                          color: Colors.black12,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              width: 100.w,
                              height: 100.h,
                              padding: const EdgeInsets.all(20),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                image: DecorationImage(
                                  image: NetworkImage(productData.productImage),
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
                                  crossAxisAlignment: CrossAxisAlignment.start,
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
                                          onTap: () => deleteMyCartData(
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
                                        SizedBox(width: 75.w),
                                        orderCounter != 1
                                            ? GestureDetector(
                                                onTap: () {
                                                  setState(() {
                                                    orderCounter--;
                                                  });
                                                  updateCartDataToFirebase(
                                                    context,
                                                    productData.productId,
                                                    productData.productPrice,
                                                    orderCounter,
                                                  );
                                                },
                                                child: const Icon(
                                                  Icons.remove,
                                                ),
                                              )
                                            : const Icon(
                                                Icons.remove,
                                              ),
                                        SizedBox(width: 10.w),
                                        Text(
                                          '$orderCounter',
                                          style: const TextStyle(
                                            color: Colors.redAccent,
                                          ),
                                        ),
                                        SizedBox(width: 10.w),
                                        GestureDetector(
                                          onTap: () {
                                            setState(() {
                                              orderCounter++;
                                            });
                                            updateCartDataToFirebase(
                                              context,
                                              productData.productId,
                                              productData.productPrice,
                                              orderCounter,
                                            );
                                          },
                                          child: const Icon(
                                            Icons.add,
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
            );
          },
        ),
        Expanded(child: Container()),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Text(
              "Sub Total : ",
              style: TextStyle(
                color: Colors.black,
                fontSize: 18.sp,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(width: 30.w),
            Container(
              height: 30.h,
              width: 90.w,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: Colors.grey,
                borderRadius: BorderRadius.circular(8.r),
              ),
              child: Builder(
                builder: (context) {
                  return Text(
                    "Rs. ",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 18.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  );
                },
              ),
            ),
          ],
        ),
        SizedBox(height: 30.h),
        InkWell(
          onTap: () => Navigator.of(context).push(
            MaterialPageRoute(
              builder: (_) => const BuyNow(),
            ),
          ),
          child: Container(
            height: 50.h,
            width: MediaQuery.of(context).size.width / 2.5,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: const Color(0xFFFA9F00),
            ),
            child: Center(
              child: Text(
                "Buy Now",
                style: TextStyle(
                  fontSize: 20.sp,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ),
        SizedBox(height: 30.h),
      ],
    );
  }
}
