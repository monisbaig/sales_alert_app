import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sales_alert_app/User_directory/screens/bottom_navigator.dart';

import '../auth/controller/user_auth_controller.dart';

class AllBrandCollections extends ConsumerStatefulWidget {
  final String brandId;
  final String brandName;
  final String brandImage;
  final String brandCategory;
  final String brandCollection;

  const AllBrandCollections({
    super.key,
    required this.brandId,
    required this.brandName,
    required this.brandImage,
    required this.brandCategory,
    required this.brandCollection,
  });

  @override
  ConsumerState<AllBrandCollections> createState() =>
      _AllBrandCollectionsState();
}

class _AllBrandCollectionsState extends ConsumerState<AllBrandCollections> {
  int? addedToCartIndex;
  int? addedToFavoriteIndex;
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

  void saveFavoritesToFirebase(
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
    ref.watch(userAuthControllerProvider).saveFavoritesToFirebase(
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
        title: Text('${widget.brandCollection} Collection'),
        backgroundColor: Colors.orangeAccent,
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
          padding: const EdgeInsets.only(top: 10, left: 10, right: 10),
          child: FutureBuilder(
            future: ref
                .watch(userAuthControllerProvider)
                .getDataByCollection(widget.brandId, widget.brandCollection),
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
                  var productId = snapshot.data?.elementAt(index).productId;
                  var productName = snapshot.data?.elementAt(index).name;
                  var productImage = snapshot.data?.elementAt(index).photo;
                  var productPrice = snapshot.data?.elementAt(index).price;
                  var productQuantity =
                      snapshot.data?.elementAt(index).quantity;
                  var productColor = snapshot.data?.elementAt(index).color;
                  var productSize = snapshot.data?.elementAt(index).size;
                  var productCategory =
                      snapshot.data?.elementAt(index).category;

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
                                image: NetworkImage(productImage ?? ''),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          SizedBox(height: 10.h),
                          Text(
                            productName ?? '',
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
                                productPrice ?? '',
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
                            productSize.toString().toUpperCase(),
                            style: TextStyle(
                              color: Colors.black.withOpacity(0.8),
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 10.h),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              IconButton(
                                onPressed: () {
                                  addedToFavoriteIndex = index;
                                  orderQuantity = 1;
                                  saveFavoritesToFirebase(
                                    context,
                                    productId,
                                    productName,
                                    productImage,
                                    productPrice,
                                    productColor,
                                    productSize,
                                    orderQuantity,
                                    widget.brandId,
                                  );
                                },
                                icon: Icon(
                                  addedToFavoriteIndex == index
                                      ? Icons.favorite_outlined
                                      : Icons.favorite_border_outlined,
                                  color: Colors.redAccent,
                                  size: 25.sp,
                                ),
                              ),
                              OutlinedButton(
                                style: OutlinedButton.styleFrom(
                                  backgroundColor: addedToCartIndex == index
                                      ? Colors.green
                                      : Colors.redAccent,
                                ),
                                onPressed: () {
                                  addedToCartIndex = index;
                                  orderQuantity = 1;
                                  cartDataToFirebase(
                                    context,
                                    productId,
                                    productName,
                                    productImage,
                                    productPrice,
                                    productColor,
                                    productSize,
                                    orderQuantity,
                                    widget.brandId,
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
