
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../Common_component/my_TextField.dart';
import '../../../Common_component/my_button.dart';
import 'add_fimage.dart';




class f_item extends StatefulWidget {
  const f_item({super.key});

  @override
  State<f_item> createState() => f_itemState();
}
final item_fnamecontroller = TextEditingController();
final item_fpricecontroller = TextEditingController();
final item_fquantitycontroller = TextEditingController();
final item_fdescriptioncontroller = TextEditingController();

class f_itemState extends State<f_item> {
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
              MyTextField(controller: item_fnamecontroller, hintText: '', obscureText: false),
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
              MyTextField(controller: item_fpricecontroller, hintText: '', obscureText: false),
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
              MyTextField(controller: item_fquantitycontroller, hintText: '', obscureText: false),
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
              MyTextField(controller: item_fdescriptioncontroller, hintText: '', obscureText: false),
              SizedBox(height: 60.h),
              MyButton(
                  label: "Next",
                  onPress: () {
                    if(!item_fnamecontroller.text.isEmpty && !item_fpricecontroller.text.isEmpty
                        &&!item_fquantitycontroller.text.isEmpty &&!item_fdescriptioncontroller.text.isEmpty)
                      Navigator.push(context,MaterialPageRoute(builder: (context) => add_fimage()));
                  }
              ),


            ],
          ),
        ),
      ),
    );
  }
}