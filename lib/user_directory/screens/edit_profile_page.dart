import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:sales_alert_app/Common_component/my_text_field.dart';
import 'package:sales_alert_app/utils/utils.dart';

import '../../Common_component/loader.dart';
import '../auth/controller/user_auth_controller.dart';
import 'bottom_navigator.dart';

class EditProfilePage extends ConsumerStatefulWidget {
  const EditProfilePage({super.key});

  @override
  ConsumerState<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends ConsumerState<EditProfilePage> {
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final addressController = TextEditingController();
  File? profileImage;
  String? image;

  void selectImage() async {
    profileImage = await pickImageFromGallery();
    setState(() {});
  }

  void updateUserDataToFirebase() {
    String address = addressController.text.trim();
    if (address.isNotEmpty && profileImage != null) {
      ref.read(userAuthControllerProvider).updateUserDataToFirebase(
            context,
            nameController.text,
            addressController.text,
            profileImage,
          );
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (_) => BottomNavigator(),
        ), //signUserIn
      );
    } else {
      Fluttertoast.showToast(msg: 'Please select profile image');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
          future: ref.watch(userAuthControllerProvider).getUserDetails(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Loader();
            }
            nameController.text = snapshot.data?.name ?? '';
            emailController.text = snapshot.data?.email ?? '';
            addressController.text = snapshot.data?.address ?? '';
            image = snapshot.data?.profileImage ??
                'https://pbs.twimg.com/profile_images/923557898218889216/g4BH7Arj.jpg';

            return Container(
              padding: const EdgeInsets.only(left: 16, top: 25, right: 16),
              child: GestureDetector(
                onTap: () {
                  FocusScope.of(context).unfocus();
                },
                child: ListView(
                  children: [
                    Text(
                      "Your Profile",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 25.sp,
                          fontWeight: FontWeight.w500),
                    ),
                    SizedBox(height: 15.h),
                    Center(
                      child: Stack(
                        children: [
                          Container(
                            width: 130.w,
                            height: 130.h,
                            decoration: BoxDecoration(
                              border: Border.all(
                                  width: 4.w,
                                  color: Theme.of(context)
                                      .scaffoldBackgroundColor),
                              boxShadow: [
                                BoxShadow(
                                  spreadRadius: 2,
                                  blurRadius: 10,
                                  color: Colors.black.withOpacity(0.1),
                                  offset: const Offset(0, 10),
                                )
                              ],
                              shape: BoxShape.circle,
                              image: profileImage == null
                                  ? DecorationImage(
                                      fit: BoxFit.cover,
                                      image: NetworkImage(image!),
                                    )
                                  : DecorationImage(
                                      fit: BoxFit.cover,
                                      image: FileImage(profileImage!),
                                    ),
                            ),
                          ),
                          Positioned(
                            bottom: 0,
                            right: 0,
                            child: Container(
                              height: 40.h,
                              width: 40.w,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(
                                  width: 4.w,
                                  color:
                                      Theme.of(context).scaffoldBackgroundColor,
                                ),
                                color: Colors.green,
                              ),
                              child: IconButton(
                                padding: EdgeInsets.only(bottom: 1.h),
                                onPressed: selectImage,
                                icon: const Icon(Icons.edit),
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 35.h),
                    Container(
                      alignment: Alignment.topLeft,
                      margin: const EdgeInsets.only(left: 30),
                      child: Text(
                        "Name",
                        style: TextStyle(
                          fontSize: 14.sp,
                        ),
                      ),
                    ),
                    SizedBox(height: 10.h),
                    MyTextField(
                      controller: nameController,
                      hintText: 'Enter your name',
                      obscureText: false,
                      color: Colors.black12,
                    ),
                    SizedBox(height: 10.h),
                    Container(
                      alignment: Alignment.topLeft,
                      margin: const EdgeInsets.only(left: 30),
                      child: Text(
                        "Email",
                        style: TextStyle(
                          fontSize: 14.sp,
                        ),
                      ),
                    ),
                    SizedBox(height: 10.h),
                    MyTextField(
                      controller: emailController,
                      hintText: 'Enter your email',
                      obscureText: false,
                      enable: false,
                      color: Colors.black12,
                    ),
                    SizedBox(height: 10.h),
                    Container(
                      alignment: Alignment.topLeft,
                      margin: const EdgeInsets.only(left: 30),
                      child: Text(
                        "Address",
                        style: TextStyle(
                          fontSize: 14.sp,
                        ),
                      ),
                    ),
                    SizedBox(height: 10.h),
                    MyTextField(
                      controller: addressController,
                      hintText: 'Enter your address',
                      obscureText: false,
                      color: Colors.black12,
                    ),
                    SizedBox(height: 30.h),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          width: 200.w,
                          child: OutlinedButton(
                            style: OutlinedButton.styleFrom(
                              backgroundColor: Colors.redAccent,
                            ),
                            onPressed: updateUserDataToFirebase,
                            child: Text(
                              "Save",
                              style: TextStyle(
                                fontSize: 14.sp,
                                letterSpacing: 2.2,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            );
          }),
    );
  }
}
// appBar: AppBar(
//   backgroundColor: Theme.of(context).scaffoldBackgroundColor,
//   elevation: 1,
//   leading: IconButton(
//     icon: const Icon(
//       Icons.arrow_back,
//       color: Colors.green,
//     ),
//     onPressed: () => Navigator.of(context).push(
//       MaterialPageRoute(
//         builder: (_) => const BottomNavigator(),
//       ),
//     ),
//   ),
// ),

// Widget buildTextField(
//     String labelText, String placeholder, bool isPasswordTextField) {
//   return Padding(
//     padding: const EdgeInsets.only(bottom: 16.0),
//     child: TextField(
//       // obscureText: isPasswordTextField ? showPassword : false,
//       decoration: InputDecoration(
//           suffixIcon: isPasswordTextField
//               ? IconButton(
//                   onPressed: () {
//                     setState(() {
//                       // showPassword = !showPassword;
//                     });
//                   },
//                   icon: const Icon(
//                     Icons.remove_red_eye,
//                     color: Colors.grey,
//                   ),
//                 )
//               : null,
//           contentPadding: const EdgeInsets.only(bottom: 3),
//           labelText: labelText,
//           floatingLabelBehavior: FloatingLabelBehavior.always,
//           hintText: placeholder,
//           hintStyle: TextStyle(
//             fontSize: 16.sp,
//             fontWeight: FontWeight.bold,
//             color: Colors.black,
//           )),
//     ),
//   );
// }
