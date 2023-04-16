import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sales_alert_app/brands/auth/controller/brand_auth_controller.dart';
import 'package:sales_alert_app/utils/utils.dart';

import '../../Common_component/my_button.dart';
import '../../Common_component/my_text_field.dart';
import 'clothing/clothing_categories.dart';
import 'electronics/electronics_categories.dart';
import 'furniture/furniture_categories.dart';

class BrandDetails extends ConsumerStatefulWidget {
  const BrandDetails({super.key});

  @override
  ConsumerState<BrandDetails> createState() => _BrandDetailsState();
}

class _BrandDetailsState extends ConsumerState<BrandDetails> {
  File? image;
  bool isLoading = false;
  final brandDetailController = TextEditingController();
  final categories = [
    "Clothing",
    "Electronics",
    "Furniture",
  ];
  String? selectedItem = "Clothing";

  @override
  void dispose() {
    super.dispose();
    brandDetailController.dispose();
  }

  void selectImage() async {
    image = await pickImageFromGallery();
    setState(() {});
  }

  void storeUserData() {
    String name = brandDetailController.text.trim();
    if (name.isNotEmpty) {
      ref.read(brandAuthControllerProvider).saveBrandDataToFirebase(
            context,
            name,
            image,
            selectedItem!,
          );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(height: 20.h),
                Text(
                  "Brand Details",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 35.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 60.h),
                Text(
                  "You’ll have your customized store  ready to use in a \nfew steps .",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 15.sp,
                  ),
                ),
                SizedBox(height: 70.h),
                image != null
                    ? CircleAvatar(
                        backgroundImage: FileImage(image!),
                        radius: 50,
                      )
                    : const SizedBox(),
                Padding(
                  padding: EdgeInsets.only(right: 260.r),
                  child: Text(
                    "Brand Name",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 15.sp,
                    ),
                  ),
                ),
                SizedBox(height: 20.h),
                MyTextField(
                  controller: brandDetailController,
                  hintText: '',
                  obscureText: false,
                ),
                SizedBox(height: 40.0.h),
                Padding(
                  padding: EdgeInsets.only(right: 240.r),
                  child: Text(
                    "Brand Category",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 15.sp,
                    ),
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.all(.0),
                ),
                Padding(
                  padding: EdgeInsets.all(22.0.r),
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
                    icon: const Icon(
                      Icons.arrow_drop_down_circle,
                      color: Color(0xFFDB3022),
                    ),
                    dropdownColor: Colors.red,
                    decoration: const InputDecoration(
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Color(0xFFDB3022)),
                      ),
                      prefixIcon: Padding(
                        padding: EdgeInsets.all(10.0),
                        child: Icon(
                          Icons.add_business_rounded,
                          color: Color(0xFFDB3022),
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white),
                      ),
                      fillColor: Colors.white,
                      filled: true,
                    ),
                  ),
                ),
                SizedBox(height: 20.h),
                SizedBox(
                  child: Padding(
                    padding: EdgeInsets.only(right: 270.r),
                    child: Text(
                      "Brand Logo",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 15.sp,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 20.h),
                InkWell(
                  onTap: selectImage,
                  child: Container(
                    height: 57.h,
                    width: 350.w,
                    color: Colors.white,
                    child: const Icon(
                      Icons.add_a_photo_outlined,
                      color: Color(0xFFDB3022),
                      size: 40,
                    ),
                  ),
                ),
                SizedBox(height: 70.h),
                MyButton(
                  label: "Save",
                  onPress: () {
                    storeUserData();
                    if (selectedItem == 'Clothing') {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (_) => const ClothingCategories(),
                        ), //signUserIn
                      );
                    }
                    if (selectedItem == 'Electronics') {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (_) => const ElectronicsCategories(),
                        ), //signUserIn
                      );
                    }
                    if (selectedItem == 'Furniture') {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (_) => const FurnitureCategories(),
                        ), //signUserIn
                      );
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// File? image;
//
// final _picker = ImagePicker();
// Future getImage({required source}) async {
//   final pickedFile = await _picker.pickImage(source: source);
//   if (pickedFile != null) {
//     image = File(pickedFile.path);
//     image = await _cropImage(imageFile: image!);
//     setState(() {});
//   } else {}
// }
//
// Future<File?> _cropImage({required File imageFile}) async {
//   CroppedFile? croppedImage =
//       await ImageCropper().cropImage(sourcePath: imageFile.path);
//   if (croppedImage == null) {
//     print("return null");
//     return null;
//   }
//   print("return crop image");
//   return File(croppedImage.path);
// }
