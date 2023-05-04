import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sales_alert_app/brands/auth/controller/brand_auth_controller.dart';

import '../../../common_component/loader.dart';
import 'update_products.dart';

class TotalInventory extends ConsumerStatefulWidget {
  final String collection;

  const TotalInventory({super.key, required this.collection});

  @override
  ConsumerState<TotalInventory> createState() => _TotalInventoryState();
}

class _TotalInventoryState extends ConsumerState<TotalInventory> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.black,
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 100.h),
            Text(
              'Total Inventory',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 40.sp,
              ),
            ),
            SizedBox(height: 80.h),
            FutureBuilder(
              future: ref
                  .watch(brandAuthControllerProvider)
                  .getCollectionData(widget.collection),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Loader();
                }

                return DataTable(
                  columnSpacing: 30,
                  horizontalMargin: 30,
                  columns: <DataColumn>[
                    const DataColumn(
                      label: Text(""),
                    ),
                    DataColumn(
                      label: Text(
                        "Name",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 15.sp,
                        ),
                      ),
                    ),
                    DataColumn(
                      label: Text(
                        "Category",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 15.sp,
                        ),
                      ),
                    ),
                    DataColumn(
                      label: Text(
                        "Price",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 15.sp,
                        ),
                      ),
                    ),
                    DataColumn(
                      label: Text(
                        "Stock",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 15.sp,
                        ),
                      ),
                    ),
                  ],
                  rows: List.generate(
                    snapshot.data?.length ?? 0,
                    (index) {
                      var productCollection = widget.collection;
                      var productData = snapshot.data!.elementAt(index);

                      return DataRow(
                        cells: [
                          DataCell(
                            GestureDetector(
                              child: Image.network(
                                snapshot.data!.elementAt(index).photo,
                                width: 40.w,
                                height: 40.h,
                                fit: BoxFit.cover,
                              ),
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => UpdateProduct(
                                      productCollection: productCollection,
                                      productId: productData.productId,
                                      productPhoto: productData.photo,
                                      productDiscountPrice:
                                          productData.discountPrice,
                                      productName: productData.name,
                                      productPrice: productData.price,
                                      productQuantity: productData.quantity,
                                      productDescription:
                                          productData.description,
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                          DataCell(
                            Text(
                              snapshot.data!.elementAt(index).name,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 12.sp,
                              ),
                            ),
                          ),
                          DataCell(
                            Text(
                              snapshot.data!.elementAt(index).mainCategory,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 12.sp,
                              ),
                            ),
                            showEditIcon: false,
                            placeholder: false,
                          ),
                          DataCell(
                            Text(
                              snapshot.data!.elementAt(index).price.toString(),
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 12.sp,
                              ),
                            ),
                            showEditIcon: false,
                            placeholder: false,
                          ),
                          DataCell(
                            Text(
                              snapshot.data!
                                  .elementAt(index)
                                  .quantity
                                  .toString(),
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 12.sp,
                              ),
                            ),
                            showEditIcon: false,
                            placeholder: false,
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
      ),
    );
  }
}
