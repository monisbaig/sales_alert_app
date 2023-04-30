import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:sales_alert_app/user_directory/auth/controller/user_auth_controller.dart';

class MyOrders extends ConsumerStatefulWidget {
  const MyOrders({Key? key}) : super(key: key);

  @override
  ConsumerState<MyOrders> createState() => _MyOrdersState();
}

class _MyOrdersState extends ConsumerState<MyOrders> {
  var _expanded = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Orders'),
        backgroundColor: Colors.orangeAccent,
      ),
      body: FutureBuilder(
        future: ref.watch(userAuthControllerProvider).getOrderPlacedData(),
        builder: (context, snapshot) {
          return snapshot.data == null || snapshot.data!.isEmpty
              ? Center(
                  heightFactor: 2,
                  child: Image.asset(
                    'lib/user_directory/user_images/empty-cart.png',
                    width: 300.w,
                    height: 300.h,
                  ),
                )
              : ListView.builder(
                  itemCount: snapshot.data!.length,
                  itemBuilder: (context, index) {
                    var productData = snapshot.data?.elementAt(index);

                    return AnimatedContainer(
                      duration: const Duration(milliseconds: 300),
                      height: _expanded
                          ? min(productData!.products.length * 20 + 110, 200)
                          : 95,
                      child: Card(
                        color: Colors.white38,
                        margin: const EdgeInsets.all(8),
                        child: Padding(
                          padding: const EdgeInsets.only(top: 10),
                          child: Column(
                            children: [
                              ListTile(
                                title: Text('Rs: ${productData!.totalAmount}'),
                                subtitle: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      DateFormat('dd-MM-yyyy hh:mm')
                                          .format(productData.orderDate),
                                    ),
                                    Text(productData.orderStatus),
                                  ],
                                ),
                                trailing: IconButton(
                                  icon: Icon(
                                    _expanded
                                        ? Icons.expand_less
                                        : Icons.expand_more,
                                  ),
                                  onPressed: () {
                                    setState(() {
                                      _expanded = !_expanded;
                                    });
                                  },
                                ),
                              ),
                              AnimatedContainer(
                                duration: const Duration(milliseconds: 300),
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 15, vertical: 4),
                                height: _expanded
                                    ? min(productData.products.length * 20 + 10,
                                        100)
                                    : 0,
                                child: ListView(
                                  children: productData.products
                                      .map(
                                        (prod) => Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              '${prod.productName} (${prod.productColor}, ${prod.productSize})',
                                              style: const TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            Text(
                                              '${prod.orderQuantity}x Rs.${prod.productPrice}',
                                              style: const TextStyle(
                                                fontSize: 18,
                                                color: Colors.grey,
                                              ),
                                            ),
                                          ],
                                        ),
                                      )
                                      .toList(),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                );
        },
      ),
    );
  }
}
