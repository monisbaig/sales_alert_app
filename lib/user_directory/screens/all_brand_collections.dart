import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../Common_component/loader.dart';
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
  void cartDataToFirebase(
    context,
    productId,
    productName,
    productImage,
    productPrice,
    productColor,
    productSize,
    brandId,
    brandName,
  ) {
    ref.watch(userAuthControllerProvider).cartDataToFirebase(
          context,
          productId,
          productName,
          productImage,
          productPrice,
          productColor,
          productSize,
          brandId,
          brandName,
        );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('${widget.brandCollection} Collection'),
        backgroundColor: Colors.orangeAccent,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(top: 10, left: 10, right: 10),
          child: FutureBuilder(
            future: ref
                .watch(userAuthControllerProvider)
                .getDataByCollection(widget.brandId, widget.brandCollection),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Loader();
              }
              return GridView.builder(
                itemCount: snapshot.data?.length ?? 0,
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  childAspectRatio: 0.7,
                  crossAxisCount: 2,
                  crossAxisSpacing: 14,
                ),
                itemBuilder: (context, index) {
                  var productId = snapshot.data!.elementAt(index).productId;
                  var productName = snapshot.data!.elementAt(index).name;
                  var productImage = snapshot.data!.elementAt(index).photo;
                  var productPrice = snapshot.data!.elementAt(index).price;
                  var productQuantity =
                      snapshot.data!.elementAt(index).quantity;
                  var productColor = snapshot.data!.elementAt(index).color;
                  var productSize = snapshot.data!.elementAt(index).size;
                  var productCategory =
                      snapshot.data!.elementAt(index).category;

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
                                '1500' ?? '',
                                style: TextStyle(
                                  color: Colors.grey,
                                  decoration: TextDecoration.lineThrough,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 10.h),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              IconButton(
                                onPressed: () {},
                                icon: Icon(
                                  Icons.favorite_border_outlined,
                                  color: Colors.redAccent,
                                  size: 25.sp,
                                ),
                              ),
                              OutlinedButton(
                                style: OutlinedButton.styleFrom(
                                  backgroundColor: Colors.redAccent,
                                ),
                                onPressed: () {
                                  cartDataToFirebase(
                                    context,
                                    productId,
                                    productName,
                                    productImage,
                                    productPrice,
                                    productColor,
                                    productSize,
                                    widget.brandId,
                                    widget.brandName,
                                  );
                                },
                                child: const Text(
                                  "Add to cart",
                                  style: TextStyle(
                                    color: Colors.white,
                                  ),
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
