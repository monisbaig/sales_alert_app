import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:sales_alert_app/brands/auth/controller/brand_auth_controller.dart';

import '../../../common_component/my_button.dart';
import '../../../common_component/my_text_field.dart';
import '../../../utils/utils.dart';
import '../../auth/controller/brand_notification_controller.dart';

class UpdateProduct extends ConsumerStatefulWidget {
  final String productCollection;
  final String productId;
  final String productPhoto;
  final String productName;
  final String productPrice;
  final String productDiscountPrice;
  final String productQuantity;
  final String productDescription;

  const UpdateProduct({
    super.key,
    required this.productCollection,
    required this.productId,
    required this.productPhoto,
    required this.productName,
    required this.productPrice,
    required this.productDiscountPrice,
    required this.productQuantity,
    required this.productDescription,
  });

  @override
  ConsumerState<UpdateProduct> createState() => _UpdateProductState();
}

class _UpdateProductState extends ConsumerState<UpdateProduct> {
  final nameController = TextEditingController();
  final priceController = TextEditingController();
  final discountController = TextEditingController();
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
    discountController.text = widget.productDiscountPrice;
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
    ref.read(brandAuthControllerProvider).updateCategoryDataToFirebase(
          context,
          widget.productCollection,
          widget.productId,
          nameController.text.trim(),
          priceController.text.trim(),
          quantityController.text.trim(),
          descriptionController.text.trim(),
        );
    setState(() {
      isLoading = false;
    });
  }

  void updateDiscountPrice() {
    setState(() {
      isLoading = true;
    });
    if (discountController.text.isNotEmpty) {
      ref.read(brandAuthControllerProvider).updateDiscountPrice(
            context,
            widget.productCollection,
            widget.productId,
            discountController.text.trim(),
          );
      getTokenAndSendNotificationToUserProduct();
    } else {
      Fluttertoast.showToast(msg: 'Fill out the field first!');
    }

    setState(() {
      isLoading = false;
    });
  }

  void getTokenAndSendNotificationToUserProduct() {
    ref
        .read(brandNotificationControllerProvider)
        .getTokenAndSendNotificationToUserProduct(
          widget.productId,
          widget.productName,
        );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                      width: 40.w,
                      height: 40.h,
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
                                size: 25,
                                color: Color(0xFFDB3022),
                              ),
                            ),
                    ),
                    SizedBox(width: 25.w),
                    Container(
                      width: 40.w,
                      height: 40.h,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.white,
                      ),
                      child: GestureDetector(
                        child: const Icon(
                          Icons.discount,
                          size: 25,
                          color: Color(0xFFDB3022),
                        ),
                        onTap: () => showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              title: const Text('Discount Offer'),
                              content: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Container(
                                    alignment: Alignment.topLeft,
                                    margin: EdgeInsets.only(left: 27.w),
                                    child: Text(
                                      "Discount Price",
                                      style: TextStyle(
                                        fontSize: 14.sp,
                                      ),
                                    ),
                                  ),
                                  SizedBox(height: 5.h),
                                  MyTextField(
                                    controller: discountController,
                                    hintText: '',
                                    obscureText: false,
                                    color: Colors.grey,
                                  ),
                                ],
                              ),
                              actions: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor:
                                            const Color(0xFFDB3022),
                                      ),
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                      child: const Text('Cancel'),
                                    ),
                                    SizedBox(width: 5.w),
                                    ElevatedButton(
                                      onPressed: updateDiscountPrice,
                                      child: const Text('Submit'),
                                    ),
                                  ],
                                ),
                              ],
                            );
                          },
                        ),
                      ),
                    ),
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
                SizedBox(height: 20.h),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
