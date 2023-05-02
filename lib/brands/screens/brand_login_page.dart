import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:sales_alert_app/brands/auth/controller/brand_auth_controller.dart';
import 'package:sales_alert_app/brands/screens/brand_register.dart';

import '../../common_component/my_button.dart';
import '../../common_component/my_text_field.dart';
import 'forgot_password.dart';

class BrandLoginPage extends ConsumerStatefulWidget {
  const BrandLoginPage({super.key});

  @override
  ConsumerState<BrandLoginPage> createState() => _BrandLoginPageState();
}

class _BrandLoginPageState extends ConsumerState<BrandLoginPage> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  bool isLoading = false;

  @override
  void dispose() {
    super.dispose();
    emailController.dispose();
    passwordController.dispose();
  }

  void login() {
    setState(() {
      isLoading = true;
    });
    String email = emailController.text.trim();
    String password = passwordController.text.trim();
    if (email.isNotEmpty && password.isNotEmpty) {
      ref.read(brandAuthControllerProvider).loginWithEmail(
            context,
            email,
            password,
          );
    } else {
      Fluttertoast.showToast(msg: 'Fill out all the fields!');
    }
    setState(() {
      isLoading = false;
    });
  }

  void signInWithGoogle() {
    ref.watch(brandAuthControllerProvider).signInWithGoogle(context);
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
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: 80.h),
                Center(
                  child: Text(
                    'Log In',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 40.sp,
                    ),
                  ),
                ),

                SizedBox(height: 50.h),
                Container(
                  alignment: Alignment.topLeft,
                  margin: const EdgeInsets.only(left: 30),
                  child: Text("Email",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 14.sp,
                      )),
                ),
                SizedBox(height: 10.h),
                // username Text_field
                MyTextField(
                  controller: emailController,
                  hintText: 'Enter email',
                  obscureText: false,
                ),

                SizedBox(height: 30.h),

                Container(
                  alignment: Alignment.topLeft,
                  margin: const EdgeInsets.only(left: 30),
                  child: Text("Password",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 14.sp,
                      )),
                ),
                SizedBox(height: 10.h),
                // password Text_field
                MyTextField(
                  controller: passwordController,
                  hintText: 'Enter password',
                  obscureText: true,
                ),

                SizedBox(height: 30.h),
                // forgot password?
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      GestureDetector(
                        child: const Text(
                          'Forgot Password',
                          style: TextStyle(color: Colors.white),
                        ),
                        onTap: () {
                          Navigator.of(context).pushReplacement(
                            MaterialPageRoute(
                              builder: (BuildContext context) =>
                                  const ForgotPassword(),
                            ),
                          );
                        },
                      ),
                      const Icon(Icons.arrow_right_alt,
                          color: Color(0xFFDB3022)),
                    ],
                  ),
                ),

                SizedBox(height: 25.h),
                // sign in button
                isLoading == true
                    ? const Center(
                        child: CircularProgressIndicator(),
                      )
                    : MyButton(
                        label: "Login",
                        onPress: login,
                      ),
                SizedBox(height: 10.h),
                Container(
                  alignment: Alignment.bottomCenter,
                  margin: const EdgeInsets.only(top: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        "Don't have any account? ",
                        style: TextStyle(color: Colors.white),
                      ),
                      InkWell(
                        child: const Text(
                          'Sign Up Now',
                          style: TextStyle(color: Colors.red),
                        ),
                        onTap: () {
                          Navigator.of(context).pushReplacement(
                            MaterialPageRoute(
                              builder: (BuildContext context) =>
                                  const BrandRegisterScreen(),
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 10.h),
                // or continue with
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: Row(
                    children: [
                      const Expanded(
                        child: Divider(
                          thickness: 1,
                          color: Color(0xFFD7B4B4),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10.0),
                        child: Image.asset(
                          'lib/common_images/OR_logo.png',
                          height: 45.h,
                        ),
                      ),
                      const Expanded(
                        child: Divider(
                          thickness: 1,
                          color: Color(0xFFD7B4B4),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 30.h),
                Center(
                  child: Text(
                    "Login with Social account",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20.sp,
                    ),
                  ),
                ),
                SizedBox(height: 10.h),
                // google sign in button
                GestureDetector(
                  onTap: () {
                    signInWithGoogle();
                  },
                  child: CircleAvatar(
                    backgroundColor: Colors.transparent,
                    backgroundImage: const AssetImage(
                      'lib/common_images/google_logo.png',
                    ),
                    radius: 35.sp,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
