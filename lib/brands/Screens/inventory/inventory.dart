
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'inventory_products.dart';

class inventory extends StatefulWidget {
  const inventory({super.key});

  @override
  State<inventory> createState() => inventoryState();
}
  class inventoryState extends State<inventory> {
    @override
    Widget build(BuildContext context) {
      return Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.black,
         body: Container(
          child:Column(
          children: [

             SizedBox(height: 100.h),
                Text('Inventory ',
                  style:TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 40.sp,
                  ),
                  ),
                  SizedBox(height: 80.h),

              DataTable(
                  columnSpacing: 30,
                  horizontalMargin: 30,
              columns:  <DataColumn>[
                DataColumn(label: Text(""),
                ),

                DataColumn(
                  label: Text("Name",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 15.sp,
                      )),
                ),

                DataColumn(
                 label: Text("Category",
                     style: TextStyle(
                       color: Colors.white,
                       fontSize: 15.sp,
                     )),
                ),
                DataColumn(
                  label: Text("Price",
                    style: TextStyle(
                    color: Colors.white,
                      fontSize: 15.sp,
                  )
                  ),
                ),
                DataColumn(
                  label: Text("Stock",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 15.sp,
                      )
                  ),
                ),

              ],
              rows: items.map((invent) => DataRow(
              cells: [
                DataCell(
                  GestureDetector(
                    child: Image.asset(invent.imagepath,
                      width:40.w,
                      height: 40.h,
                      fit:BoxFit.cover,
                    ),
                    onTap: ()
                    {
                      Navigator.push(context,MaterialPageRoute(builder: (context) => invent_products()));
                    },
                  ),
                ),
                DataCell(
                  Text(invent.PName,
                      style:  TextStyle(
                        color: Colors.white,
                        fontSize: 12.sp,
                      ) ),
                 // showEditIcon: true,
                 // placeholder: true,
                ),
                DataCell(
                  Text(invent.Category,
                      style:  TextStyle(
                        color: Colors.white,
                        fontSize: 12.sp,
                      )),
                  showEditIcon: false,
                  placeholder: false,
                ),
                DataCell(
                  Text(invent.Price,
                      style:  TextStyle(
                        color: Colors.white,
                        fontSize: 12.sp,
                      )),
                  showEditIcon: false,
                  placeholder: false,
                ),
                DataCell(
                  Text(invent.stock,
                      style:  TextStyle(
                        color: Colors.white,
                        fontSize: 12.sp,
                      )),
                  showEditIcon: false,
                  placeholder: false,
                ),

              ],
            ),
              )
          .toList()),
      ]
      ),
      ),
      );
    }
  }

class invent {
  String imagepath;
  String PName;
  String Category;
  String Price;
  String stock;
  invent({required this.imagepath,required this.PName, required this.Category,required this.Price,required this.stock,});
}

var items = <invent>[

  invent(imagepath:'lib/Brand_directory/Brand_images/shoes1.png',PName: "Shoes", Category: "Men",Price: '240.55',stock: '15',),
  invent(imagepath:'lib/Brand_directory/Brand_images/handbag1.jpg',PName: "Handbag", Category: "Women",Price: '95.99',stock: '20',),
  invent(imagepath:'lib/Brand_directory/Brand_images/shirt1.jpg',PName: "T-Shirt", Category: "Men",Price: '40.35',stock: '10',),
  invent(imagepath:'lib/Brand_directory/Brand_images/jeans1.jpg',PName: "Jeans", Category: "Kids",Price: '70.00',stock: '15',),
];