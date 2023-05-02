import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../auth/controller/user_auth_controller.dart';
import '../widgets/product_images.dart';
import 'buy_now.dart';

class ProductDetailScreen extends ConsumerStatefulWidget {
  final String productId;
  final String productName;
  final String productPhoto;
  final String productPrice;
  final String productColor;
  final String productSize;
  final String productDescription;
  final String brandId;

  const ProductDetailScreen({
    super.key,
    required this.productId,
    required this.productName,
    required this.productPhoto,
    required this.productPrice,
    required this.productColor,
    required this.productSize,
    required this.productDescription,
    required this.brandId,
  });

  @override
  ConsumerState<ProductDetailScreen> createState() =>
      _ProductDetailScreenState();
}

class _ProductDetailScreenState extends ConsumerState<ProductDetailScreen> {
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
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: MediaQuery.of(context).size.height / 2,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                    color: const Color(0xFFD4ECF7),
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(30.r),
                      bottomRight: Radius.circular(30.r),
                    )),
                child: Stack(
                  children: [
                    Center(
                      child: ProductImageSlider(
                        productImage: widget.productPhoto,
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
                          size: 30,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 10.h),
              Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Flexible(
                          child: Text(
                            widget.productName,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 22.sp,
                            ),
                          ),
                        ),
                        IconButton(
                          onPressed: () {
                            orderQuantity = 1;
                            saveFavoritesToFirebase(
                              context,
                              widget.productId,
                              widget.productName,
                              widget.productPhoto,
                              widget.productPrice,
                              widget.productColor,
                              widget.productSize,
                              orderQuantity,
                              widget.brandId,
                            );
                          },
                          icon: Icon(
                            Icons.favorite_outlined,
                            color: Colors.redAccent,
                            size: 25.sp,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 10.h),
                    Row(
                      children: [
                        RatingBar.builder(
                          initialRating: 2.5,
                          minRating: 1,
                          direction: Axis.horizontal,
                          allowHalfRating: true,
                          itemCount: 5,
                          itemSize: 25,
                          itemBuilder: (context, _) => const Icon(
                            Icons.star,
                            color: Colors.amber,
                          ),
                          onRatingUpdate: (rating) {},
                        )
                      ],
                    ),
                    const SizedBox(height: 15),
                    Row(
                      children: [
                        Text(
                          widget.productPrice,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 22.sp,
                          ),
                        ),
                        SizedBox(width: 5.w),
                        const Text(
                          "Rs. 500",
                          style: TextStyle(
                            color: Colors.black45,
                            decoration: TextDecoration.lineThrough,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 15.h),
                    Text(
                      widget.productDescription,
                      style: TextStyle(fontSize: 15.sp),
                      textAlign: TextAlign.justify,
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
      bottomNavigationBar: Container(
        height: 70,
        margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 30),
        child:
            // CartScreen
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          InkWell(
            onTap: () {
              orderQuantity = 1;
              cartDataToFirebase(
                context,
                widget.productId,
                widget.productName,
                widget.productPhoto,
                widget.productPrice,
                widget.productColor,
                widget.productSize,
                orderQuantity.toString(),
                widget.brandId,
              );
            },
            child: Container(
              height: 50.h,
              width: MediaQuery.of(context).size.width / 2.5,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: const Color(0xFFFF1300),
              ),
              child: Center(
                  child: Text(
                "Add to Cart",
                style: TextStyle(
                  fontSize: 20.sp,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              )),
            ),
          ),
          InkWell(
            onTap: () => Navigator.of(context)
                .push(MaterialPageRoute(builder: (_) => const BuyNow())),
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
              )),
            ),
          ),
        ]),
      ),
    );
  }
}
