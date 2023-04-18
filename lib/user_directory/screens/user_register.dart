import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../auth/controller/user_auth_controller.dart';
import 'user_login_page.dart';

class UserRegisterScreen extends ConsumerStatefulWidget {
  const UserRegisterScreen({Key? key}) : super(key: key);
  @override
  ConsumerState<UserRegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends ConsumerState<UserRegisterScreen> {
  final _form = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  bool isLoading = false;

  @override
  void dispose() {
    super.dispose();
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
  }

  void register() {
    setState(() {
      isLoading = true;
    });
    var isValid = _form.currentState!.validate();
    if (isValid) {
      String name = nameController.text.trim();
      String email = emailController.text.trim();
      String password = passwordController.text.trim();

      ref.read(userAuthControllerProvider).signUpWithEmail(
            context,
            name,
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
    ref.watch(userAuthControllerProvider).signInWithGoogle(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      //SafeArea avoid notch area
      body: SingleChildScrollView(
        child: Column(
          children: [
            //Text main
            SizedBox(height: 100.h),
            Center(
              child: Text(
                'Register your Brand',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 30.sp,
                ),
              ),
            ),
            SizedBox(height: 40.h),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
              child: Form(
                key: _form,
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 15, right: 15),
                      child: TextFormField(
                        controller: nameController,
                        decoration: InputDecoration(
                          hintText: 'Enter your full name',
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8.0),
                            borderSide: const BorderSide(color: Colors.white),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: const BorderSide(color: Colors.white),
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                          fillColor: Colors.black12,
                          filled: true,
                        ),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please enter your name';
                          }
                          if (value.contains('0') ||
                              value.contains('1') ||
                              value.contains('2') ||
                              value.contains('3') ||
                              value.contains('4') ||
                              value.contains('5') ||
                              value.contains('6') ||
                              value.contains('7') ||
                              value.contains('8') ||
                              value.contains('9')) {
                            return 'Please enter a valid name';
                          }
                          return null;
                        },
                      ),
                    ),
                    const SizedBox(height: 25),
                    Padding(
                      padding: const EdgeInsets.only(left: 15, right: 15),
                      child: TextFormField(
                        controller: emailController,
                        decoration: InputDecoration(
                          hintText: 'Enter your email address',
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8.0),
                            borderSide: const BorderSide(color: Colors.white),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: const BorderSide(color: Colors.white),
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                          fillColor: Colors.black12,
                          filled: true,
                        ),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please enter your email address';
                          }
                          if (!value.contains('@')) {
                            return 'Please enter valid email address';
                          }
                          return null;
                        },
                      ),
                    ),
                    const SizedBox(height: 25),
                    Padding(
                      padding: const EdgeInsets.only(left: 15, right: 15),
                      child: TextFormField(
                        controller: passwordController,
                        decoration: InputDecoration(
                          hintText: 'Enter your password',
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8.0),
                            borderSide: const BorderSide(color: Colors.white),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: const BorderSide(color: Colors.white),
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                          fillColor: Colors.black12,
                          filled: true,
                        ),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please enter your password';
                          }
                          if (value.length < 6) {
                            return 'Password must contains at least six characters';
                          }
                          return null;
                        },
                      ),
                    ),
                    const SizedBox(height: 45),
                    isLoading == true
                        ? const Center(
                            child: CircularProgressIndicator(),
                          )
                        : Container(
                            padding: const EdgeInsets.all(18),
                            margin: const EdgeInsets.symmetric(horizontal: 50),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(30),
                              color: const Color(0xFFDB3022),
                            ),
                            child: InkWell(
                              onTap: register,
                              child: const Center(
                                child: Text(
                                  'Register',
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                          ),
                  ],
                ),
              ),
            ),
            Container(
              alignment: Alignment.bottomCenter,
              margin: const EdgeInsets.only(top: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "Already have an account? ",
                  ),
                  InkWell(
                    child: const Text(
                      'Sign In',
                      style: TextStyle(color: Colors.red),
                    ),
                    onTap: () {
                      Navigator.of(context).pushReplacement(
                        MaterialPageRoute(
                          builder: (BuildContext context) =>
                              const UserLoginPage(),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
            SizedBox(height: 10.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
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
                    'lib/Common_images/OR_logo.png',
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
            SizedBox(height: 20.h),
            Container(
              alignment: Alignment.bottomCenter,
              child: Text(
                "Sign Up With Social Account",
                style: TextStyle(
                  fontSize: 16.sp,
                ),
              ),
            ),
            SizedBox(height: 10.h),
            GestureDetector(
              onTap: () {
                signInWithGoogle();
              },
              child: CircleAvatar(
                backgroundColor: Colors.transparent,
                backgroundImage: const AssetImage(
                  'lib/Common_images/google_logo.png',
                ),
                radius: 35.sp,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
