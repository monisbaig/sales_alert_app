import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sales_alert_app/user_directory/screens/bottom_navigator.dart';
import 'package:sales_alert_app/user_directory/screens/product_detail_screen.dart';

import '../auth/controller/user_auth_controller.dart';

class AllProductCategory extends ConsumerStatefulWidget {
  final String category;

  const AllProductCategory({
    super.key,
    required this.category,
  });

  @override
  ConsumerState<AllProductCategory> createState() =>
      _AllBrandCollectionsState();
}

class _AllBrandCollectionsState extends ConsumerState<AllProductCategory> {
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.category),
        backgroundColor: const Color(0xFFDB3022),
        actions: [
          Padding(
            padding: EdgeInsets.only(top: 12, right: 10.w),
            child: StreamBuilder(
              stream: ref
                  .watch(userAuthControllerProvider)
                  .getMyCartData()
                  .asStream(),
              builder: (context, snapshot) {
                return GestureDetector(
                  onTap: () {
                    Navigator.of(context).pushReplacement(
                      MaterialPageRoute(
                        builder: (context) => BottomNavigator(selectPage: 2),
                      ),
                    );
                  },
                  child: Badge(
                    label: Text('${snapshot.data?.length ?? 0}'),
                    child: Icon(
                      Icons.shopping_cart,
                      size: 30.sp,
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding:
              const EdgeInsets.only(top: 10, left: 10, right: 10, bottom: 10),
          child: FutureBuilder(
            future: ref
                .watch(userAuthControllerProvider)
                .getDataByCategory(widget.category),
            builder: (context, snapshot) {
              return GridView.builder(
                itemCount: snapshot.data?.length ?? 0,
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  childAspectRatio: 0.61,
                  crossAxisCount: 2,
                  mainAxisSpacing: 14,
                  crossAxisSpacing: 14,
                ),
                itemBuilder: (context, index) {
                  var productData = snapshot.data?.elementAt(index);

                  return GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => ProductDetailScreen(
                            productId: productData.productId,
                            productName: productData.name,
                            productPhoto: productData.photo,
                            productPrice: productData.price,
                            productDiscountPrice: productData.discountPrice,
                            productColor: productData.color,
                            productSize: productData.size,
                            productDescription: productData.description,
                            brandId: productData.brandId,
                          ),
                        ),
                      );
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
                                image: NetworkImage(productData?.photo ?? ''),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          SizedBox(height: 10.h),
                          Flexible(
                            child: Text(
                              productData?.name ?? '',
                              overflow: TextOverflow.ellipsis,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 18.sp,
                                color: Colors.black.withOpacity(0.8),
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          SizedBox(height: 10.h),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                productData?.discountPrice == ''
                                    ? productData!.price
                                    : productData!.discountPrice,
                                style: TextStyle(
                                  color: Colors.redAccent,
                                  fontSize: 18.sp,
                                ),
                              ),
                              SizedBox(width: 8.w),
                              Text(
                                productData.discountPrice == ''
                                    ? productData.discountPrice
                                    : productData.price,
                                style: const TextStyle(
                                  color: Colors.grey,
                                  decoration: TextDecoration.lineThrough,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 10.h),
                          Text(
                            productData.size.toString().toUpperCase(),
                            style: TextStyle(
                              color: Colors.black.withOpacity(0.8),
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 10.h),
                          OutlinedButton(
                            style: OutlinedButton.styleFrom(
                              backgroundColor: addedToCartIndex == index
                                  ? Colors.green
                                  : Colors.redAccent,
                            ),
                            onPressed: () {
                              var orderPrice = productData.discountPrice == ''
                                  ? productData.price
                                  : productData.discountPrice;

                              addedToCartIndex = index;
                              orderQuantity = 1;
                              cartDataToFirebase(
                                context,
                                productData.productId,
                                productData.name,
                                productData.photo,
                                orderPrice,
                                productData.color,
                                productData.size,
                                orderQuantity.toString(),
                                productData.brandId,
                              );
                            },
                            child: Text(
                              addedToCartIndex == index
                                  ? "Added      "
                                  : "Add to cart",
                              textAlign: TextAlign.center,
                              style: const TextStyle(color: Colors.white),
                            ),
                          ),
                          SizedBox(width: 8.w),
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
