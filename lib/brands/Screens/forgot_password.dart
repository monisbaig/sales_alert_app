import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../Common_component/my_button.dart';
import '../../Common_component/my_text_field.dart';
import '../../user_directory/auth/controller/user_auth_controller.dart';

class ForgotPassword extends ConsumerStatefulWidget {
  const ForgotPassword({super.key});

  @override
  ConsumerState<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends ConsumerState<ForgotPassword> {
  final emailController = TextEditingController();

  bool isLoading = false;

  @override
  void dispose() {
    super.dispose();
    emailController.dispose();
  }

  void sendPasswordResetRequest() {
    setState(() {
      isLoading = true;
    });
    String email = emailController.text.trim();
    if (email.isNotEmpty) {
      ref.read(userAuthControllerProvider).sendPasswordResetRequest(email);
    } else {
      Fluttertoast.showToast(msg: 'Fill out all the fields!');
    }
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
        child: Column(
          children: [
            SizedBox(height: 150.h),
            Container(
              alignment: Alignment.topLeft,
              margin: EdgeInsets.only(left: 30.r),
              child: Text(
                'Forgot Password',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 40.sp,
                ),
              ),
            ),
            SizedBox(height: 80.h),
            Container(
              alignment: Alignment.topLeft,
              margin: EdgeInsets.only(left: 30.r),
              child: Text(
                  "Please, enter your email address. You will receive a link to create a new password via email.",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16.sp,
                  )),
            ),
            SizedBox(height: 20.h),
            MyTextField(
              controller: emailController,
              hintText: 'Enter email',
              obscureText: false,
              color: Colors.white,
            ),
            SizedBox(height: 60.h),
            MyButton(
              label: "Send",
              onPress: sendPasswordResetRequest,
            ),
          ],
        ),
      ),
    );
  }
}
