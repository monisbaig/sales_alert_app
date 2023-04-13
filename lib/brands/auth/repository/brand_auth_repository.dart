// ignore_for_file: use_build_context_synchronously

import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:sales_alert_app/brands/auth/repository/brand_firebase_storage_repository.dart';
import 'package:sales_alert_app/brands/models/brand_model.dart';

import '../../Screens/brand_details.dart';
import '../../Screens/brand_login_page.dart';

final brandAuthRepositoryProvider = Provider((ref) {
  return BrandAuthRepository(
    auth: FirebaseAuth.instance,
    firestore: FirebaseFirestore.instance,
  );
});

class BrandAuthRepository {
  final FirebaseAuth auth;
  final FirebaseFirestore firestore;

  BrandAuthRepository({
    required this.auth,
    required this.firestore,
  });

  Future<BrandModel?> getCurrentBrandData() async {
    var brandData =
        await firestore.collection('brands').doc(auth.currentUser?.uid).get();
    BrandModel? brand;
    if (brandData.data() != null) {
      brand = BrandModel.fromMap(brandData.data()!);
    }
    return brand;
  }

  Future<void> signUpWithEmail({
    required BuildContext context,
    required String email,
    required String password,
  }) async {
    try {
      await auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      await sendEmailVerification();

      Fluttertoast.showToast(msg: 'Account created successfully');

      Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(
          builder: (context) => const BrandLoginPage(),
        ),
        (route) => false,
      );
    } on FirebaseAuthException catch (e) {
      Fluttertoast.showToast(msg: e.message!);
    }
  }

  Future<void> loginWithEmail({
    required BuildContext context,
    required String email,
    required String password,
  }) async {
    try {
      await auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      if (!auth.currentUser!.emailVerified) {
        await sendEmailVerification();
      }
      Fluttertoast.showToast(msg: 'Logged in successfully');

      Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(
          builder: (context) => const BrandDetails(),
        ),
        (route) => false,
      );
    } on FirebaseAuthException catch (e) {
      Fluttertoast.showToast(msg: e.message!);
    }
  }

  Future<void> sendEmailVerification() async {
    try {
      auth.currentUser!.sendEmailVerification();
      Fluttertoast.showToast(msg: 'Email verification sent!');
    } on FirebaseException catch (e) {
      Fluttertoast.showToast(msg: e.message!);
    }
  }

  Future<void> signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

      final GoogleSignInAuthentication googleAuth =
          await googleUser!.authentication;

      if (googleAuth.accessToken != null && googleAuth.idToken != null) {
        final credential = GoogleAuthProvider.credential(
          accessToken: googleAuth.accessToken,
          idToken: googleAuth.idToken,
        );
        UserCredential brandCredential =
            await auth.signInWithCredential(credential);
        Fluttertoast.showToast(msg: brandCredential.user!.email!);

        // if(brandCredential.user != null) {
        //   if(brandCredential.additionalUserInfo!.isNewUser) {
        //
        //   }
        //   else{
        //
        //   }
        // }
      }
    } on FirebaseException catch (e) {
      Fluttertoast.showToast(msg: e.message!);
    }
  }

  Future<void> signOut() async {
    try {
      await auth.signOut();
      Fluttertoast.showToast(msg: 'Signed out Successfully!');
    } on FirebaseException catch (e) {
      Fluttertoast.showToast(msg: e.message!);
    }
  }

  Future<void> saveBrandDataToFirebase({
    required BuildContext context,
    required String name,
    required File? logo,
    required String category,
    required ProviderRef ref,
  }) async {
    try {
      String uId = auth.currentUser!.uid;
      String? logoUrl;

      if (logo != null) {
        logoUrl = await ref
            .read(brandFirebaseStorageRepositoryProvider)
            .storeFileToFirebase('brandLogo/$uId', logo);
      }

      var brand = BrandModel(
        uId: uId,
        name: name,
        email: auth.currentUser!.email!,
        logo: logoUrl!,
        category: category,
      );

      await firestore.collection('brands').doc(uId).set(brand.toMap());

      Fluttertoast.showToast(msg: 'Brand Info saved successfully!');

      // Navigator.pushAndRemoveUntil(
      //   context,
      //   MaterialPageRoute(
      //     builder: (context) => ,
      //   ),
      //       (route) => false,
      // );
    } on FirebaseAuthException catch (e) {
      Fluttertoast.showToast(msg: e.message!);
    }
  }
}
