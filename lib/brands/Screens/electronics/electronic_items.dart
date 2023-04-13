import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../Common_component/my_TextField.dart';
import '../../../Common_component/my_button.dart';
import 'add_eimage.dart';


class electronic_item extends StatefulWidget {
  const electronic_item({super.key});

  @override
  State<electronic_item> createState() => electronic_itemState();
}
final item_enamecontroller = TextEditingController();
final item_epricecontroller = TextEditingController();
final item_equantitycontroller = TextEditingController();
final item_edescriptioncontroller = TextEditingController();

class electronic_itemState extends State<electronic_item> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.black,
      body: SafeArea(
        child:Center(
          child:Column(
            children: [

              SizedBox(height: 100.h),

              Text('Item Details ',
                style:
                TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 40.sp,
                ),
              ),
              SizedBox(height: 80.h),
              Container(
                alignment:Alignment.topLeft,
                margin: EdgeInsets.only(left: 30.w),
                child:  Text("Item Name",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 14.sp,
                    )
                ),
              ),
              SizedBox(height: 10.h),
              MyTextField(controller: item_enamecontroller, hintText: '', obscureText: false),
              SizedBox(height: 30.h),
              Container(
                alignment:Alignment.topLeft,
                margin: EdgeInsets.only(left: 30.w),
                child:  Text("Item price",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 14.sp,
                    )
                ),
              ),
              SizedBox(height: 10.h),
              MyTextField(controller: item_epricecontroller, hintText: '', obscureText: false),
              SizedBox(height: 30.h),

              Container(
                alignment:Alignment.topLeft,
                margin: EdgeInsets.only(left: 30.w),
                child:  Text("Quantity",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 14.sp,
                    )
                ),
              ),
              SizedBox(height: 10.h),
              MyTextField(controller: item_equantitycontroller, hintText: '', obscureText: false),
              SizedBox(height: 30.h),
              Container(
                alignment:Alignment.topLeft,
                margin: EdgeInsets.only(left: 30.w),
                child:  Text("Description",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 14.sp,
                    )
                ),
              ),
              SizedBox(height: 10.h),
              MyTextField(controller: item_edescriptioncontroller, hintText: '', obscureText: false),
              SizedBox(height: 60.h),
              MyButton(
                  label: "Next",
                  onPress: () {
                    if(!item_enamecontroller.text.isEmpty && !item_epricecontroller.text.isEmpty
                        &&!item_equantitycontroller.text.isEmpty &&!item_edescriptioncontroller.text.isEmpty)
                      Navigator.push(context,MaterialPageRoute(builder: (context) => add_eimage()));
                  }
              ),


            ],
          ),
        ),
      ),
    );
  }
}