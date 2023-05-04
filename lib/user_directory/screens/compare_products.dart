import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sales_alert_app/user_directory/auth/controller/user_auth_controller.dart';
import 'package:sales_alert_app/user_directory/screens/product_one_category.dart';
import 'package:sales_alert_app/user_directory/screens/product_two_category.dart';

class CompareProducts extends ConsumerStatefulWidget {
  const CompareProducts({Key? key}) : super(key: key);

  @override
  ConsumerState<CompareProducts> createState() => _CompareProductsState();
}

class _CompareProductsState extends ConsumerState<CompareProducts> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Compare Products'),
        backgroundColor: const Color(0xFFDB3022),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 22.h),
        child: Column(
          children: [
            IntrinsicHeight(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  StreamBuilder(
                    stream: ref
                        .watch(userAuthControllerProvider)
                        .getSavedProductOne()
                        .asStream(),
                    builder: (context, snapshot) {
                      var productId = snapshot.data?[1] ?? '';

                      return Column(
                        children: [
                          Container(
                            width: 155.w,
                            height: 155.h,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12.sp),
                              image: DecorationImage(
                                image: NetworkImage(
                                  snapshot.data?[0] ??
                                      'https://busken.com/wp-content/uploads/2019/09/product_dummy-1.jpg',
                                ),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          SizedBox(height: 10.h),
                          OutlinedButton(
                            style: OutlinedButton.styleFrom(
                              backgroundColor: Colors.redAccent,
                            ),
                            onPressed: () {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) =>
                                      const ProductOneCategory(),
                                ),
                              );
                            },
                            child: const Text(
                              'Select Product One',
                              style: TextStyle(
                                color: Colors.white,
                              ),
                            ),
                          ),
                          SizedBox(height: 10.h),
                          productId == ''
                              ? Container()
                              : StreamBuilder(
                                  stream: ref
                                      .read(userAuthControllerProvider)
                                      .getProductRatingData(productId),
                                  builder: (context, snapshot) {
                                    var totalRating = snapshot.data;
                                    return Row(
                                      children: [
                                        RatingBar.builder(
                                          initialRating: totalRating ?? 0,
                                          minRating: 1,
                                          direction: Axis.horizontal,
                                          allowHalfRating: true,
                                          itemCount: 5,
                                          itemSize: 25,
                                          itemBuilder: (context, _) =>
                                              const Icon(
                                            Icons.star,
                                            color: Colors.amber,
                                          ),
                                          onRatingUpdate: (rating) {},
                                        ),
                                      ],
                                    );
                                  },
                                ),
                          SizedBox(
                            width: 170.w,
                            child: DataTable(
                              columnSpacing: 15,
                              columns: <DataColumn>[
                                const DataColumn(
                                  label: Expanded(
                                    child: Text(
                                      'Name',
                                      style: TextStyle(
                                        fontStyle: FontStyle.italic,
                                      ),
                                    ),
                                  ),
                                ),
                                DataColumn(
                                  label: Expanded(
                                    child: Text(
                                      overflow: TextOverflow.clip,
                                      snapshot.data?[2] ?? '',
                                      style: const TextStyle(
                                        fontWeight: FontWeight.normal,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                              rows: <DataRow>[
                                DataRow(
                                  cells: <DataCell>[
                                    const DataCell(
                                      Text(
                                        'Price',
                                        style: TextStyle(
                                          fontStyle: FontStyle.italic,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                    DataCell(
                                      Text(
                                        snapshot.data?[3] ?? '',
                                      ),
                                    ),
                                  ],
                                ),
                                DataRow(
                                  cells: <DataCell>[
                                    const DataCell(
                                      Text(
                                        'Color',
                                        style: TextStyle(
                                          fontStyle: FontStyle.italic,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                    DataCell(
                                      Text(
                                        snapshot.data?[4] ?? '',
                                      ),
                                    ),
                                  ],
                                ),
                                DataRow(
                                  cells: <DataCell>[
                                    const DataCell(
                                      Text(
                                        'Desc',
                                        style: TextStyle(
                                          fontStyle: FontStyle.italic,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                    DataCell(
                                      Container(
                                        padding: EdgeInsets.only(
                                          right: 20.w,
                                          top: 10.h,
                                        ),
                                        width: 115.w,
                                        child: SingleChildScrollView(
                                          child: Text(
                                            snapshot.data?[5] ?? '',
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                  const VerticalDivider(
                    color: Colors.redAccent,
                    thickness: 2,
                  ),
                  StreamBuilder(
                    stream: ref
                        .watch(userAuthControllerProvider)
                        .getSavedProductTwo()
                        .asStream(),
                    builder: (context, snapshot) {
                      var productId = snapshot.data?[1] ?? '';
                      return Column(
                        children: [
                          Container(
                            width: 155.w,
                            height: 155.h,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12.sp),
                              image: DecorationImage(
                                image: NetworkImage(
                                  snapshot.data?[0] ??
                                      'https://busken.com/wp-content/uploads/2019/09/product_dummy-1.jpg',
                                ),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          SizedBox(height: 10.h),
                          OutlinedButton(
                            style: OutlinedButton.styleFrom(
                              backgroundColor: Colors.redAccent,
                            ),
                            onPressed: () {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) =>
                                      const ProductTwoCategory(),
                                ),
                              );
                            },
                            child: const Text(
                              'Select Product Two',
                              style: TextStyle(
                                color: Colors.white,
                              ),
                            ),
                          ),
                          SizedBox(height: 10.h),
                          productId == ''
                              ? Container()
                              : StreamBuilder(
                                  stream: ref
                                      .read(userAuthControllerProvider)
                                      .getProductRatingData(productId),
                                  builder: (context, snapshot) {
                                    var totalRating = snapshot.data;
                                    return Row(
                                      children: [
                                        RatingBar.builder(
                                          initialRating: totalRating ?? 0,
                                          minRating: 1,
                                          direction: Axis.horizontal,
                                          allowHalfRating: true,
                                          itemCount: 5,
                                          itemSize: 25,
                                          itemBuilder: (context, _) =>
                                              const Icon(
                                            Icons.star,
                                            color: Colors.amber,
                                          ),
                                          onRatingUpdate: (rating) {},
                                        ),
                                      ],
                                    );
                                  },
                                ),
                          SizedBox(
                            width: 170.w,
                            child: DataTable(
                              columnSpacing: 15,
                              columns: <DataColumn>[
                                const DataColumn(
                                  label: Expanded(
                                    child: Text(
                                      'Name',
                                      style: TextStyle(
                                        fontStyle: FontStyle.italic,
                                      ),
                                    ),
                                  ),
                                ),
                                DataColumn(
                                  label: Expanded(
                                    child: Text(
                                      overflow: TextOverflow.clip,
                                      snapshot.data?[2] ?? '',
                                      style: const TextStyle(
                                        fontWeight: FontWeight.normal,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                              rows: <DataRow>[
                                DataRow(
                                  cells: <DataCell>[
                                    const DataCell(
                                      Text(
                                        'Price',
                                        style: TextStyle(
                                          fontStyle: FontStyle.italic,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                    DataCell(
                                      Text(
                                        snapshot.data?[3] ?? '',
                                      ),
                                    ),
                                  ],
                                ),
                                DataRow(
                                  cells: <DataCell>[
                                    const DataCell(
                                      Text(
                                        'Color',
                                        style: TextStyle(
                                          fontStyle: FontStyle.italic,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                    DataCell(
                                      Text(
                                        snapshot.data?[4] ?? '',
                                      ),
                                    ),
                                  ],
                                ),
                                DataRow(
                                  cells: <DataCell>[
                                    const DataCell(
                                      Text(
                                        'Desc',
                                        style: TextStyle(
                                          fontStyle: FontStyle.italic,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                    DataCell(
                                      Container(
                                        padding: EdgeInsets.only(
                                          right: 20.w,
                                          top: 10.h,
                                        ),
                                        width: 115.w,
                                        child: SingleChildScrollView(
                                          child: Text(
                                            snapshot.data?[5] ?? '',
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
