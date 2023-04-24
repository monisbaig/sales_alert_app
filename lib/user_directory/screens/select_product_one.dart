import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sales_alert_app/User_directory/screens/bottom_navigator.dart';

import '../auth/controller/user_auth_controller.dart';

class SelectProductOne extends ConsumerStatefulWidget {
  final String collection;

  const SelectProductOne({super.key, required this.collection});

  @override
  ConsumerState<SelectProductOne> createState() => _SelectProductOneState();
}

class _SelectProductOneState extends ConsumerState<SelectProductOne> {
  void getSelectedProductOne(
    String productName,
    String productPrice,
    String productSize,
    String productImage,
    String productColor,
  ) {
    ref.watch(userAuthControllerProvider).getSelectedProductOne(
          productName,
          productPrice,
          productSize,
          productImage,
          productColor,
        );
    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(
        builder: (context) => BottomNavigator(selectPage: 3),
      ),
      (route) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Select your Product'),
        backgroundColor: Colors.orangeAccent,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(top: 10, left: 10, right: 10),
          child: FutureBuilder(
            future: ref
                .watch(userAuthControllerProvider)
                .getAllBrandProductsData(widget.collection),
            builder: (context, snapshot) {
              return GridView.builder(
                itemCount: snapshot.data?.length ?? 0,
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  childAspectRatio: 0.61,
                  crossAxisCount: 2,
                  crossAxisSpacing: 14,
                ),
                itemBuilder: (context, index) {
                  var productData = snapshot.data?.elementAt(index);

                  return GestureDetector(
                    onTap: () {},
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
                                image: NetworkImage(productData?.photo ?? ''),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          SizedBox(height: 10.h),
                          Text(
                            productData?.name ?? '',
                            style: TextStyle(
                              fontSize: 18.sp,
                              color: Colors.black.withOpacity(0.8),
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 10.h),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                productData?.price ?? '',
                                style: TextStyle(
                                  color: Colors.redAccent,
                                  fontSize: 18.sp,
                                ),
                              ),
                              SizedBox(width: 8.w),
                              const Text(
                                '1500',
                                style: TextStyle(
                                  color: Colors.grey,
                                  decoration: TextDecoration.lineThrough,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 10.h),
                          Text(
                            productData!.size.toString().toUpperCase(),
                            style: TextStyle(
                              color: Colors.black.withOpacity(0.8),
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 10.h),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              OutlinedButton(
                                style: OutlinedButton.styleFrom(
                                  backgroundColor: Colors.redAccent,
                                ),
                                onPressed: () {
                                  getSelectedProductOne(
                                    productData.name,
                                    productData.price,
                                    productData.size,
                                    productData.color,
                                    productData.photo,
                                  );
                                },
                                child: const Text(
                                  "Select",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  );
                },
              );
            },
          ),
        ),
      ),
    );
  }
}
