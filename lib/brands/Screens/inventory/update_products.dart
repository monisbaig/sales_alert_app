import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:sales_alert_app/brands/auth/controller/brand_auth_controller.dart';

import '../../../Common_component/my_TextField.dart';
import '../../../Common_component/my_button.dart';
import '../../../utils/utils.dart';

class UpdateProduct extends ConsumerStatefulWidget {
  final String productCollection;
  final String productId;
  final String productPhoto;
  final String productName;
  final String productPrice;
  final String productQuantity;
  final String productDescription;

  const UpdateProduct({
    super.key,
    required this.productCollection,
    required this.productId,
    required this.productPhoto,
    required this.productName,
    required this.productPrice,
    required this.productQuantity,
    required this.productDescription,
  });

  @override
  ConsumerState<UpdateProduct> createState() => _UpdateProductState();
}

class _UpdateProductState extends ConsumerState<UpdateProduct> {
  final nameController = TextEditingController();
  final priceController = TextEditingController();
  final quantityController = TextEditingController();
  final descriptionController = TextEditingController();
  File? image;
  String? oldImage;
  bool isLoading = false;
  bool isDeleted = false;

  @override
  void initState() {
    super.initState();
    nameController.text = widget.productName;
    priceController.text = widget.productPrice;
    quantityController.text = widget.productQuantity;
    descriptionController.text = widget.productDescription;
    oldImage = widget.productPhoto;
  }

  void deleteItem() {
    setState(() {
      isDeleted = true;
    });
    ref.read(brandAuthControllerProvider).deleteItemById(
          context,
          widget.productCollection,
          widget.productId,
        );
    setState(() {
      isDeleted = false;
    });
  }

  void selectImage() async {
    image = await pickImageFromGallery();
    setState(() {});
  }

  void updateCategoryDataToFirebase() {
    setState(() {
      isLoading = true;
    });
    if (image == null) {
      Fluttertoast.showToast(msg: 'Please select a image');
      setState(() {
        isLoading = false;
      });
      return;
    }
    ref.read(brandAuthControllerProvider).updateCategoryDataToFirebase(
          context,
          widget.productCollection,
          widget.productId,
          nameController.text.trim(),
          priceController.text.trim(),
          image,
          quantityController.text.trim(),
          descriptionController.text.trim(),
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
                  'Update Item Details',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 30.sp,
                  ),
                ),
                SizedBox(height: 30.h),
                image == null
                    ? SizedBox(
                        height: 220.h,
                        width: 230.w,
                        child: Image.network(
                          oldImage!,
                          height: 150.h,
                          fit: BoxFit.cover,
                        ),
                      )
                    : SizedBox(
                        height: 220.h,
                        width: 230.w,
                        child: Image.file(
                          image!,
                          height: 150.h,
                          fit: BoxFit.cover,
                        ),
                      ),
                SizedBox(height: 15.h),
                ElevatedButton.icon(
                  onPressed: selectImage,
                  icon: const Icon(
                    Icons.add_a_photo,
                    color: Colors.white,
                  ),
                  label: const Text('Update Image'),
                ),
                SizedBox(height: 15.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.white,
                      ),
                      child: isDeleted == true
                          ? const Center(
                              child: CircularProgressIndicator(),
                            )
                          : GestureDetector(
                              onTap: deleteItem,
                              child: const Icon(
                                Icons.delete_forever_rounded,
                                size: 30,
                                color: Color(0xFFDB3022),
                              ),
                            ),
                    ),
                    // SizedBox(width: 25.w),
                    // Container(
                    //   decoration: const BoxDecoration(
                    //     shape: BoxShape.circle,
                    //     color: Colors.white,
                    //   ),
                    //   child: GestureDetector(
                    //     child: const Icon(
                    //       Icons.add_business,
                    //       size: 30,
                    //       color: Color(0xFFDB3022),
                    //     ),
                    //     onTap: () {},
                    //   ),
                    // ),
                  ],
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
                SizedBox(height: 12.h),
                Container(
                  alignment: Alignment.topLeft,
                  margin: EdgeInsets.only(left: 30.w),
                  child: Text(
                    "Item Price",
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
                  obscureText: false,
                ),
                SizedBox(height: 12.h),
                Container(
                  alignment: Alignment.topLeft,
                  margin: EdgeInsets.only(left: 30.w),
                  child: Text(
                    "Item Quantity",
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
                  obscureText: false,
                ),
                SizedBox(height: 12.h),
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
                  obscureText: false,
                ),
                SizedBox(height: 30.h),
                isLoading == true
                    ? const Center(
                        child: CircularProgressIndicator(),
                      )
                    : MyButton(
                        label: 'Save',
                        onPress: updateCategoryDataToFirebase,
                      ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
