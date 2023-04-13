
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../Common_component/my_TextField.dart';
import '../../../Common_component/my_button.dart';


class updatestock extends StatefulWidget {
  updatestock({super.key});
  @override
  State<updatestock> createState() => updatestockState();
}
  final quantitycontroller = TextEditingController();
  final categories = [
    "small",
    "medium",
    "Large",
    "XLarge",
    "XXLarge"
  ];
  String? selectedItem = "small";

class updatestockState extends State<updatestock> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Center(
          child: Column(
              children: [

                SizedBox(height: 80.h),
                Container(
                  child: Text('Add your Stock ',
                    style:
                    TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 40.sp,
                    ),
                  ),
                ),
                SizedBox(height: 150.h),

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
                MyTextField(controller: quantitycontroller, hintText: '', obscureText: false),
                SizedBox(height: 30.h),
                Container(
                  alignment:Alignment.topLeft,
                  margin: EdgeInsets.only(left: 30.w),
                  child:  Text("Sizes",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 14.sp,
                      )
                  ),
                ),
                SizedBox(height: 10.h),
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
                      enabledBorder: OutlineInputBorder(
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white),
                      ),
                      fillColor: Colors.white,
                      filled: true,
                    ),
                  ),
                ),
                SizedBox(height: 50.h),
                MyButton(label: 'Save',
                    onPress: ()
                      {}
                ),
              ]
          ),
        ),
      ),
    );
  }
}