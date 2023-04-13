import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class IconsScreen extends StatelessWidget {
  const IconsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Clothes"),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection("brands").snapshots(),
        builder: (BuildContext context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(
                child: CircularProgressIndicator(
              color: Colors.white,
            ));
          } else {
            return SingleChildScrollView(
              child: Column(
                // mainAxisSize: MainAxisSize.max,
                children: [
                  GridView.builder(
                      physics: const ScrollPhysics(),

                      // physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: snapshot.data?.docs.length,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        childAspectRatio: 0.7,
                        crossAxisCount: 2,
                      ),
                      itemBuilder: (context, index) {
                        DocumentSnapshot Data = snapshot.data!.docs[index];
                        return Container(
                          margin: EdgeInsets.all(10),
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
                          child: Padding(
                            padding: EdgeInsets.all(12),
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: const [
                                    Icon(
                                      Icons.favorite_border,
                                      color: Colors.redAccent,
                                    )
                                  ],
                                ),
                                SizedBox(height: 15.h),
                                Padding(
                                  padding: EdgeInsets.all(8),
                                  child: InkWell(
                                    onTap: () {},
                                    child: Image.network(
                                      Data["image"],
                                      height: 100.h,
                                      width: 200.w,
                                    ),
                                  ),
                                ),
                                SizedBox(height: 15.h),
                                Padding(
                                  padding: EdgeInsets.all(8.r),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        Data["title"],
                                        style: TextStyle(
                                          fontSize: 17.sp,
                                          color: Colors.black.withOpacity(0.8),
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      SizedBox(height: 10.h),
                                      Row(
                                        children: [
                                          Text(
                                            "        ${Data["price"]}",
                                            style: TextStyle(
                                              fontSize: 15.sp,
                                              color: Colors.redAccent,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                          SizedBox(width: 5.w),
                                          Text(
                                            "${Data["old"]}",
                                            style: TextStyle(
                                              decoration:
                                                  TextDecoration.lineThrough,
                                              fontSize: 15.sp,
                                              color:
                                                  Colors.black.withOpacity(0.4),
                                            ),
                                          ),
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      }),

                  // ListView.builder(
                  // physics: const ScrollPhysics(),

                  // // physics: NeverScrollableScrollPhysics(),
                  // shrinkWrap: true,
                  // itemCount: snapshot.data?.docs.length,
                  // itemBuilder: (context, index) {
                  //   DocumentSnapshot Data = snapshot.data!.docs[index];

                  //     return Padding(
                  //       padding: const EdgeInsets.only(
                  //         left: 10,
                  //         right: 10,
                  //       ),
                  //       child: InkWell(
                  //         onTap: () {
                  //           print(Data["Address"]);
                  //         },
                  //         child: Card(
                  //           shape: RoundedRectangleBorder(
                  //             borderRadius: BorderRadius.circular(10),
                  //           ),
                  //           child: Container(
                  //             decoration: BoxDecoration(
                  //                 color: Colors.white,
                  //                 borderRadius: BorderRadius.circular(10)),
                  //             child: Padding(
                  //               padding:
                  //                   const EdgeInsets.symmetric(horizontal: 20),
                  //               child: Column(
                  //                 crossAxisAlignment: CrossAxisAlignment.start,
                  //                 children: [
                  //                   ListTile(
                  //                     contentPadding: const EdgeInsets.only(
                  //                         left: 0.0, right: 0.0),
                  //                     leading: CircleAvatar(
                  //                       backgroundImage:
                  //                           NetworkImage(Data["image"]),
                  //                     ),
                  //                     title: Text(
                  //                       Data["price"],
                  //                       style: const TextStyle(
                  //                           fontWeight: FontWeight.bold),
                  //                     ),
                  //                     subtitle: Text(
                  //                       Data["old"],
                  //                       style: const TextStyle(
                  //                           fontWeight: FontWeight.bold),
                  //                     ),
                  //                   ),
                  //                 ],
                  //               ),
                  //             ),
                  //           ),
                  //         ),
                  //       ),
                  //     );
                  //   },
                  // ),
                ],
              ),
            );
          }
        },
      ),
    );
  }
}
