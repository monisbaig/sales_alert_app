import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sales_alert_app/brands/auth/controller/brand_auth_controller.dart';

import '../../../Common_component/my_TextField.dart';
import '../../../Common_component/my_button.dart';
import '../../../utils/utils.dart';

class ElectronicItems extends ConsumerStatefulWidget {
  final String mainCategory;

  const ElectronicItems({super.key, required this.mainCategory});

  @override
  ConsumerState<ElectronicItems> createState() => _ItemDetailsState();
}

class _ItemDetailsState extends ConsumerState<ElectronicItems> {
  final nameController = TextEditingController();
  final priceController = TextEditingController();
  final quantityController = TextEditingController();
  final descriptionController = TextEditingController();
  final colorController = TextEditingController();
  File? image;
  bool isLoading = false;

  void selectImage() async {
    image = await pickImageFromGallery();
    setState(() {});
  }

  void saveCategoryDataToFirebase() {
    setState(() {
      isLoading = true;
    });
    ref.read(brandAuthControllerProvider).saveCategoryDataToFirebase(
          context,
          widget.mainCategory,
          '',
          nameController.text.trim(),
          priceController.text.trim(),
          image,
          colorController.text.trim(),
          quantityController.text.trim(),
          descriptionController.text.trim(),
          '',
        );
    setState(() {
      isLoading = false;
    });
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
                SizedBox(height: 20.h),
                Text(
                  '${widget.mainCategory} Details',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 30.sp,
                  ),
                ),
                SizedBox(height: 5.h),
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
                  child: Text(
                    "Description",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 14.sp,
                    ),
                  ),
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
                  child: Text(
                    "Colors",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 14.sp,
                    ),
                  ),
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
                        onPress: () {
                          saveCategoryDataToFirebase();
                        },
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
