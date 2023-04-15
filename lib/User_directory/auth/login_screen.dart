import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:sales_alert_app/User_directory/auth/signup_screen.dart';

import '../screens/bottom_navigation.dart';
import 'forget_password.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  // SharedPreferences? logindata;
  bool? newuser;

  login(String email1, pass1) async {
    setState(() {
      isloading = true;
    });
    // final isvalid = _formKey.currentState!.validate();
    // if (isvalid) {
    try {
      final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email1,
        password: pass1,
      );
      // Userdata.userId = credential.user!.uid;

      // print(Userdata.userId);
      // LatLngCheck.currentuserName = credential.user!.uid;
      // ;
      // print(LatLngCheck.currentuserName);

      // ignore: use_build_context_synchronously
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
          builder: (BuildContext context) => const Screens(),
        ),
        (route) => false,
      );
      setState(() {
        isloading = false;
      });

      // logindata!.setBool("login", false);
      // logindata!.setString("username", email.text);
      // logindata!.setString("password", password.text);
    } on FirebaseAuthException catch (e) {
      setState(() {
        isloading = false;
      });
      if (e.code == 'user-not-found') {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: const Text("User not found"),
          backgroundColor: Colors.red.shade400,
          behavior: SnackBarBehavior.floating,
        ));
        print('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        setState(() {
          isloading = false;
        });
        await ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: const Text("Wrong Password"),
          backgroundColor: Colors.red.shade400,
          behavior: SnackBarBehavior.floating,
        ));
        print('Wrong password provided for that user.');
      }
    }
    // } else {}
  }

  String? passvalidation(value) {
    if (value == null || value.isEmpty) {
      return " password is required";
    } else if (value.length < 5) {
      return " password must be  5 Characters";
    } else if (value.length > 15) {
      return " password is too Long";
    } else {
      return null;
    }
  }

  // late SharedPreferences logindataa;
  // late String usernamme;
  // late String pass;
  bool isloading = false;
  // void checkiflogin() async {
  //   logindata = await SharedPreferences.getInstance();

  //   newuser = (logindata!.getBool("login") ?? true);
  //   print(newuser);
  //   if (newuser == false) {
  //     logindataa = await SharedPreferences.getInstance();
  //     setState(() {
  //       usernamme = logindataa.getString("username").toString();
  //       pass = logindataa.getString("password").toString();
  //     });
  //     login(
  //       usernamme,
  //       pass,
  //     );
  //   }
  // }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // checkiflogin();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff3c83f1),
      // backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(
              height: 100,
            ),
            const Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: EdgeInsets.only(left: 24),
                child: Text(
                  "LOGIN",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    fontSize: 32,
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 50,
            ),
            Container(
              margin: const EdgeInsets.all(22),
              padding: const EdgeInsets.all(22),
              decoration: BoxDecoration(
                  color: Colors.grey.shade200,
                  borderRadius: BorderRadius.circular(12)),
              child: Column(
                children: [
                  Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        TextFormField(
                          controller: email,
                          // validator: MultiValidator(
                          //   [
                          //     RequiredValidator(errorText: "Email is required"),
                          //     EmailValidator(errorText: "Not a valid Email"),
                          //   ],
                          // ),
                          keyboardType: TextInputType.emailAddress,
                          decoration: const InputDecoration(
                            floatingLabelBehavior: FloatingLabelBehavior.always,
                            prefix: SizedBox(
                              width: 5,
                            ),
                            labelText: "Email",
                            hintText: "Enter your email",
                            suffixIcon: Padding(
                              padding: EdgeInsets.fromLTRB(0, 20, 20, 20),
                              child: Icon(Icons.email_outlined),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        TextFormField(
                          controller: password,
                          validator: passvalidation,
                          obscureText: true,
                          decoration: const InputDecoration(
                            prefix: SizedBox(
                              width: 5,
                            ),
                            floatingLabelBehavior: FloatingLabelBehavior.always,
                            labelText: "Password",
                            hintText: "Enter your password",
                            suffixIcon: Padding(
                              padding: EdgeInsets.fromLTRB(0, 20, 20, 20),
                              child: Icon(Icons.lock_outline),
                            ),
                          ),
                        ),
                        const SizedBox(height: 30),
                        Align(
                          alignment: Alignment.centerRight,
                          child: GestureDetector(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const ForgotScreen()));
                            },
                            child: Text(
                              "Forgot Password ?",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.red.shade400,
                                  decoration: TextDecoration.underline),
                            ),
                          ),
                        ),
                        const SizedBox(height: 20),
                        isloading
                            ? const Center(child: CircularProgressIndicator())
                            : SizedBox(
                                width: double.infinity,
                                height: 46,
                                child: TextButton(
                                  style: TextButton.styleFrom(
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(24)),
                                    primary: Colors.white,
                                    backgroundColor: const Color(0xFF4167b2),
                                  ),
                                  onPressed: () {
                                    final isvalid =
                                        _formKey.currentState!.validate();
                                    if (isvalid) {
                                      login(email.text, password.text);
                                    } else {}
                                    // login();
                                  },
                                  child: const Text(
                                    "SIGN IN",
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w700,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                      ],
                    ),
                  )
                ],
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  "Don’t have an account? ",
                  style: TextStyle(fontSize: 17, color: Colors.white),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const SignupScreen(),
                      ),
                    );
                  },
                  child: const Text(
                    "SIGN UP",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      decoration: TextDecoration.underline,
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
