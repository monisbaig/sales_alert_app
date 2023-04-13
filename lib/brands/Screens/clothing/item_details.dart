import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../Common_component/my_TextField.dart';
import '../../../Common_component/my_button.dart';
import 'add_image.dart';

class add_item extends StatefulWidget {
  const add_item({super.key});

  @override
  State<add_item> createState() => add_itemState();
}

final item_namecontroller = TextEditingController();
final item_pricecontroller = TextEditingController();
final item_quantitycontroller = TextEditingController();
final item_descriptioncontroller = TextEditingController();
final item_colorcontroller = TextEditingController();
final categories = ["small", "medium", "Large", "XLarge", "XXLarge"];
String? selectedItem = "small";

class add_itemState extends State<add_item> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Center(
          child: Column(
            children: [
              SizedBox(height: 10.h),
              Text(
                'Item Details ',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 40.sp,
                ),
              ),
              SizedBox(height: 30.h),
              Container(
                alignment: Alignment.topLeft,
                margin: EdgeInsets.only(left: 30.w),
                child: Text("Item Name",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 14.sp,
                    )),
              ),
              SizedBox(height: 8.h),
              MyTextField(
                  controller: item_namecontroller,
                  hintText: '',
                  obscureText: false),
              SizedBox(height: 15.h),
              Container(
                alignment: Alignment.topLeft,
                margin: EdgeInsets.only(left: 30.w),
                child: Text("Item price",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 14.sp,
                    )),
              ),
              SizedBox(height: 8.h),
              MyTextField(
                  controller: item_pricecontroller,
                  hintText: '',
                  obscureText: false),
              SizedBox(height: 15.h),
              Container(
                alignment: Alignment.topLeft,
                margin: EdgeInsets.only(left: 30.w),
                child: Text("Sizes",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 14.sp,
                    )),
              ),
              SizedBox(height: 8.h),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 25.w),
                child: DropdownButtonFormField(
                  value: selectedItem,
                  items: categories
                      .map(
                        (e) => DropdownMenuItem(
                          value: e,
                          child: Text(
                            e,
                            style: const TextStyle(
                              color: Colors.black,
                            ),
                          ),
                        ),
                      )
                      .toList(),
                  onChanged: (String? val) {
                    setState(() {
                      selectedItem = val;
                    });
                  },
                  dropdownColor: Colors.red,
                  decoration: const InputDecoration(
                    enabledBorder: OutlineInputBorder(),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white),
                    ),
                    fillColor: Colors.white,
                    filled: true,
                  ),
                ),
              ),
              SizedBox(height: 15.h),
              Container(
                alignment: Alignment.topLeft,
                margin: EdgeInsets.only(left: 30.w),
                child: Text("Quantity",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 14.sp,
                    )),
              ),
              SizedBox(height: 8.h),
              MyTextField(
                  controller: item_quantitycontroller,
                  hintText: '',
                  obscureText: false),
              SizedBox(height: 15.h),
              Container(
                alignment: Alignment.topLeft,
                margin: EdgeInsets.only(left: 30.w),
                child: Text("Description",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 14.sp,
                    )),
              ),
              SizedBox(height: 8.h),
              MyTextField(
                  controller: item_descriptioncontroller,
                  hintText: '',
                  obscureText: false),
              SizedBox(height: 15.h),
              Container(
                alignment: Alignment.topLeft,
                margin: EdgeInsets.only(left: 30.w),
                child: Text("Colors",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 14.sp,
                    )),
              ),
              SizedBox(height: 8.h),
              MyTextField(
                  controller: item_colorcontroller,
                  hintText: '',
                  obscureText: false),
              SizedBox(height: 20.h),
              MyButton(
                  label: "Next",
                  onPress: () {
                    if (!item_namecontroller.text.isEmpty &&
                        !item_pricecontroller.text.isEmpty &&
                        !item_quantitycontroller.text.isEmpty &&
                        !item_descriptioncontroller.text.isEmpty &&
                        !item_colorcontroller.text.isEmpty)
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => add_image()));
                  }),
            ],
          ),
        ),
      ),
    );
  }
}
