import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sales_alert_app/user_directory/auth/controller/user_auth_controller.dart';

import '../../Common_component/my_button.dart';
import 'user_success.dart';

class BuyNow extends ConsumerStatefulWidget {
  const BuyNow({super.key});

  @override
  ConsumerState<BuyNow> createState() => _BuyNowState();
}

class _BuyNowState extends ConsumerState<BuyNow> {
  final categories = [
    "Cash on Delivery",
    "JazzCash",
    "EasyPaisa",
    "Other",
  ];
  String selectedMethod = "Cash on Delivery";
  String? username;

  void fetchAndSaveOrderPlacedData({
    required String buyerName,
    required String brandId,
    required String paymentMethod,
    required String totalAmount,
  }) {
    ref.watch(userAuthControllerProvider).fetchAndSaveOrderPlacedData(
          buyerName,
          brandId,
          paymentMethod,
          totalAmount,
        );
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => const Success(
          label: 'Order placed successfully!',
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 10, top: 70),
            child: Text(
              "Checkout",
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 30.sp,
              ),
            ),
          ),
          SizedBox(height: 50.sp),
          Padding(
            padding: const EdgeInsets.only(right: 200),
            child: Text(
              "Shipping Address",
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 20.sp,
              ),
            ),
          ),
          const SizedBox(height: 20),
          StreamBuilder(
              stream: ref
                  .watch(userAuthControllerProvider)
                  .getUserDetails()
                  .asStream(),
              builder: (context, snapshot) {
                var userData = snapshot.data;
                username = userData?.name ?? '';
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    height: 150.h,
                    width: 380.w,
                    decoration: BoxDecoration(
                      color: Colors.redAccent,
                      borderRadius: BorderRadius.circular(8.r),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 10, right: 10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: 20.h),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                username!,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16.sp,
                                ),
                              ),
                              GestureDetector(
                                  child: const Icon(Icons.edit,
                                      color: Colors.white)),
                            ],
                          ),
                          SizedBox(height: 20.h),
                          Text(
                            userData?.address ?? '',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16.sp,
                            ),
                          ),
                          SizedBox(height: 20.h),
                          Text(
                            userData?.email ?? '',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16.sp,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              }),
          SizedBox(height: 10.h),
          Padding(
            padding: const EdgeInsets.only(right: 140),
            child: Text(
              "Choose Payment Method",
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 20.sp,
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(22.0.r),
            child: DropdownButtonFormField(
              value: selectedMethod,
              items: categories
                  .map(
                    (e) => DropdownMenuItem(
                      value: e,
                      child: Text(
                        e,
                        style: const TextStyle(
                          color: Colors.black,
                        ),
                      ),
                    ),
                  )
                  .toList(),
              onChanged: (String? val) {
                setState(() {
                  selectedMethod = val!;
                });
              },
              icon: const Icon(
                Icons.arrow_drop_down_circle,
                color: Color(0xFFDB3022),
              ),
              dropdownColor: Colors.red,
              decoration: const InputDecoration(
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Color(0xFFDB3022)),
                ),
                prefixIcon: Padding(
                  padding: EdgeInsets.all(10.0),
                  child: Icon(
                    Icons.payment,
                    color: Color(0xFFDB3022),
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Color(0xFFDB3022)),
                ),
                fillColor: Colors.white,
                filled: true,
              ),
            ),
          ),
          SizedBox(height: 20.h),
          StreamBuilder(
            stream: ref
                .watch(userAuthControllerProvider)
                .getMyCartData()
                .asStream(),
            builder: (context, snapshot) {
              return snapshot.connectionState == ConnectionState.waiting
                  ? const Center(
                      child: CircularProgressIndicator(),
                    )
                  : Padding(
                      padding: const EdgeInsets.only(left: 20, right: 20),
                      child: ListView.builder(
                        itemCount: 1,
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemBuilder: (context, index) {
                          var cartData = snapshot.data;

                          int total = cartData!
                              .map<int>((item) =>
                                  int.parse(item.orderQuantity) *
                                  int.parse(item.productPrice))
                              .reduce((value1, value2) => value1 + value2);

                          int grandTotal = total + 250;

                          return Column(
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "Total : ",
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 18.sp,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
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
                                          "Rs. $total",
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
                              SizedBox(height: 5.h),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "Shipping : ",
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 18.sp,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
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
                                          "Rs. 250",
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
                              SizedBox(height: 5.h),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "Grand Total : ",
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 18.sp,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
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
                                          "Rs. $grandTotal",
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
                              SizedBox(height: 35.h),
                              MyButton(
                                label: 'Confirm Order',
                                onPress: () {
                                  fetchAndSaveOrderPlacedData(
                                    buyerName: username!,
                                    brandId: cartData.elementAt(index).brandId,
                                    paymentMethod: selectedMethod,
                                    totalAmount: grandTotal.toString(),
                                  );
                                },
                              ),
                            ],
                          );
                        },
                      ),
                    );
            },
          ),
        ],
      ),
    );
  }
}
