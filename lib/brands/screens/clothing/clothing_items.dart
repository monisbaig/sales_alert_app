import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:sales_alert_app/brands/auth/controller/brand_auth_controller.dart';
import 'package:sales_alert_app/brands/auth/controller/brand_notification_controller.dart';

import '../../../common_component/my_button.dart';
import '../../../common_component/my_text_field.dart';
import '../../../utils/utils.dart';

class ClothingItems extends ConsumerStatefulWidget {
  final String mainCategory;
  final String subCategory;

  const ClothingItems(
      {super.key, required this.mainCategory, required this.subCategory});

  @override
  ConsumerState<ClothingItems> createState() => _ItemDetailsState();
}

class _ItemDetailsState extends ConsumerState<ClothingItems> {
  final nameController = TextEditingController();
  final priceController = TextEditingController();
  final quantityController = TextEditingController();
  final descriptionController = TextEditingController();
  final colorController = TextEditingController();
  final size = ["small", "medium", "large", "xl", "xxl"];
  String? selectedSize = "small";
  File? image;
  bool isLoading = false;
  bool alreadyPressed = false;

  void selectImage() async {
    image = await pickImageFromGallery();
    setState(() {});
  }

  void saveCategoryDataToFirebase() {
    setState(() {
      isLoading = true;
    });
    if (nameController.text.isNotEmpty &&
        priceController.text.isNotEmpty &&
        quantityController.text.isNotEmpty &&
        descriptionController.text.isNotEmpty) {
      ref.watch(brandAuthControllerProvider).saveCategoryDataToFirebase(
            context,
            widget.mainCategory,
            widget.subCategory,
            nameController.text.trim(),
            priceController.text.trim(),
            image,
            colorController.text.trim(),
            quantityController.text.trim(),
            descriptionController.text.trim(),
            selectedSize,
          );
      getTokenAndSendNotificationToUser();
      alreadyPressed = true;
    } else {
      Fluttertoast.showToast(msg: 'Please fill out all the fields!');
    }
    setState(() {
      isLoading = false;
    });
  }

  void getTokenAndSendNotificationToUser() {
    ref
        .read(brandNotificationControllerProvider)
        .getTokenAndSendNotificationToUser(nameController.text.trim());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.black,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Center(
            child: Column(
              children: [
                SizedBox(height: 10.h),
                Text(
                  '${widget.mainCategory} Details',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 30.sp,
                  ),
                ),
                SizedBox(height: 20.h),
                image == null
                    ? const CircleAvatar(
                        backgroundImage:
                            AssetImage('lib/brands/brand_images/profile.png'),
                        radius: 64,
                      )
                    : CircleAvatar(
                        backgroundImage: FileImage(image!),
                        radius: 64,
                      ),
                SizedBox(height: 5.h),
                ElevatedButton.icon(
                  onPressed: selectImage,
                  icon: const Icon(
                    Icons.add_a_photo,
                    color: Colors.white,
                  ),
                  label: const Text('Add Image'),
                ),
                SizedBox(height: 10.h),
                Container(
                  alignment: Alignment.topLeft,
                  margin: EdgeInsets.only(left: 30.w),
                  child: Text(
                    "Item Name",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 14.sp,
                    ),
                  ),
                ),
                SizedBox(height: 8.h),
                MyTextField(
                    controller: nameController,
                    hintText: '',
                    obscureText: false),
                SizedBox(height: 15.h),
                Container(
                  alignment: Alignment.topLeft,
                  margin: EdgeInsets.only(left: 30.w),
                  child: Text(
                    "Item price",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 14.sp,
                    ),
                  ),
                ),
                SizedBox(height: 8.h),
                MyTextField(
                    controller: priceController,
                    hintText: '',
                    obscureText: false),
                SizedBox(height: 15.h),
                Container(
                  alignment: Alignment.topLeft,
                  margin: EdgeInsets.only(left: 30.w),
                  child: Text(
                    "Sizes",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 14.sp,
                    ),
                  ),
                ),
                SizedBox(height: 8.h),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 25.w),
                  child: DropdownButtonFormField(
                    value: selectedSize,
                    items: size
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
                        selectedSize = val;
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
                  child: Text(
                    "Quantity",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 14.sp,
                    ),
                  ),
                ),
                SizedBox(height: 8.h),
                MyTextField(
                    controller: quantityController,
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
                    controller: descriptionController,
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
                    controller: colorController,
                    hintText: '',
                    obscureText: false),
                SizedBox(height: 20.h),
                isLoading == true
                    ? const Center(
                        child: CircularProgressIndicator(),
                      )
                    : MyButton(
                        label: 'Done',
                        onPress: alreadyPressed == false
                            ? saveCategoryDataToFirebase
                            : null,
                      ),
                SizedBox(height: 50.h),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
