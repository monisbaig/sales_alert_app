import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../auth/controller/user_auth_controller.dart';
import 'bottom_navigator.dart';

class SearchProductScreen extends ConsumerStatefulWidget {
  const SearchProductScreen({super.key});

  @override
  ConsumerState<SearchProductScreen> createState() =>
      _SearchProductScreenState();
}

class _SearchProductScreenState extends ConsumerState<SearchProductScreen> {
  int? addedToCartIndex;
  int? addedToFavoriteIndex;
  int? orderQuantity;
  String? productName;

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
        title: Padding(
          padding: const EdgeInsets.only(right: 20),
          child: TextField(
            decoration: InputDecoration(
              hintText: 'Search your product',
              border: UnderlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide.none,
              ),
              fillColor: Colors.white,
              filled: true,
            ),
            onChanged: (value) {
              setState(() {
                productName = value;
              });
            },
          ),
        ),
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
          child: StreamBuilder(
            stream: ref
                .watch(userAuthControllerProvider)
                .searchAllBrandProducts()
                .asStream(),
            builder: (context, snapshot) {
              var searchData = snapshot.data?.where((element) => element.name
                  .toLowerCase()
                  .replaceAll(' ', '')
                  .contains(productName!));
              return productName != null
                  ? GridView.builder(
                      itemCount: searchData?.length ?? 0,
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        childAspectRatio: 0.61,
                        crossAxisCount: 2,
                        crossAxisSpacing: 14,
                      ),
                      itemBuilder: (context, index) {
                        var productData = searchData?.elementAt(index);

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
                                      image: NetworkImage(
                                          productData?.photo ?? ''),
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
                                  productData?.size.toString().toUpperCase() ??
                                      '',
                                  style: TextStyle(
                                    color: Colors.black.withOpacity(0.8),
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SizedBox(height: 10.h),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    IconButton(
                                      onPressed: () {
                                        addedToFavoriteIndex = index;
                                        orderQuantity = 1;
                                        saveFavoritesToFirebase(
                                          context,
                                          productData!.productId,
                                          productData.name,
                                          productData.photo,
                                          productData.price,
                                          productData.color,
                                          productData.size,
                                          orderQuantity,
                                          productData.brandId,
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
                                          productData!.productId,
                                          productData.name,
                                          productData.photo,
                                          productData.price,
                                          productData.color,
                                          productData.size,
                                          orderQuantity,
                                          productData.brandId,
                                        );
                                      },
                                      child: Text(
                                        addedToCartIndex == index
                                            ? "Added      "
                                            : "Add to cart",
                                        textAlign: TextAlign.center,
                                        style: const TextStyle(
                                            color: Colors.white),
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
                    )
                  : GridView.builder(
                      itemCount: snapshot.data?.length ?? 0,
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
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
                                      image: NetworkImage(
                                          productData?.photo ?? ''),
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
                                  productData?.size.toString().toUpperCase() ??
                                      '',
                                  style: TextStyle(
                                    color: Colors.black.withOpacity(0.8),
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SizedBox(height: 10.h),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    IconButton(
                                      onPressed: () {
                                        addedToFavoriteIndex = index;
                                        orderQuantity = 1;
                                        saveFavoritesToFirebase(
                                          context,
                                          productData!.productId,
                                          productData.name,
                                          productData.photo,
                                          productData.price,
                                          productData.color,
                                          productData.size,
                                          orderQuantity,
                                          productData.brandId,
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
                                          productData!.productId,
                                          productData.name,
                                          productData.photo,
                                          productData.price,
                                          productData.color,
                                          productData.size,
                                          orderQuantity,
                                          productData.brandId,
                                        );
                                      },
                                      child: Text(
                                        addedToCartIndex == index
                                            ? "Added      "
                                            : "Add to cart",
                                        textAlign: TextAlign.center,
                                        style: const TextStyle(
                                            color: Colors.white),
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
