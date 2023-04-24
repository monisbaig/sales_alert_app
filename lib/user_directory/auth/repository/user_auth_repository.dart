// ignore_for_file: use_build_context_synchronously

import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:sales_alert_app/user_directory/auth/repository/user_firebase_storage_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../brands/models/brand_model.dart';
import '../../../brands/models/product_model.dart';
import '../../../splash/splash_screen.dart';
import '../../models/cart_model.dart';
import '../../models/user_model.dart';
import '../../screens/bottom_navigator.dart';
import '../../screens/user_login_page.dart';

final userAuthRepositoryProvider = Provider((ref) {
  return UserAuthRepository(
    auth: FirebaseAuth.instance,
    firestore: FirebaseFirestore.instance,
  );
});

class UserAuthRepository {
  final FirebaseAuth auth;
  final FirebaseFirestore firestore;

  UserAuthRepository({
    required this.auth,
    required this.firestore,
  });

  Future<UserModel?> getCurrentUserData() async {
    var userData =
        await firestore.collection('users').doc(auth.currentUser?.uid).get();
    UserModel? user;
    if (userData.data() != null) {
      user = UserModel.fromMap(userData.data()!);
    }
    return user;
  }

  Future<void> signUpWithEmail({
    required BuildContext context,
    required String name,
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

      await firestore.collection('users').doc(auth.currentUser!.uid).set({
        'uId': auth.currentUser!.uid,
        'name': name,
        'email': auth.currentUser!.email,
      });

      Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(
          builder: (context) => const UserLoginPage(),
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
        Fluttertoast.showToast(msg: 'Verify Email First');
      } else {
        Fluttertoast.showToast(msg: 'Logged in successfully');

        Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(
            builder: (context) => BottomNavigator(),
          ),
          (route) => false,
        );
      }
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

  Future<void> signInWithGoogle({required BuildContext context}) async {
    try {
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

      final GoogleSignInAuthentication googleAuth =
          await googleUser!.authentication;

      if (googleAuth.accessToken != null && googleAuth.idToken != null) {
        final credential = GoogleAuthProvider.credential(
          accessToken: googleAuth.accessToken,
          idToken: googleAuth.idToken,
        );
        UserCredential userCredential =
            await auth.signInWithCredential(credential);

        await firestore.collection('users').doc(userCredential.user!.uid).set({
          'uId': userCredential.user!.uid,
          'name': userCredential.user!.displayName,
          'email': userCredential.user!.email,
        });

        Fluttertoast.showToast(msg: userCredential.user!.email!);

        Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(
            builder: (context) => BottomNavigator(),
          ),
          (route) => false,
        );
      }
    } on FirebaseException catch (e) {
      Fluttertoast.showToast(msg: e.message!);
    }
  }

  Future<void> signOut({required BuildContext context}) async {
    try {
      await auth.signOut();
      Fluttertoast.showToast(msg: 'Signed out Successfully!');
      Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(
          builder: (_) => const Splash(),
        ),
        (route) => false,
      );
    } on FirebaseException catch (e) {
      Fluttertoast.showToast(msg: e.message!);
    }
  }

  Future<void> updateUserDataToFirebase({
    required BuildContext context,
    required String name,
    required File? profileImage,
    required String address,
    required ProviderRef ref,
  }) async {
    try {
      String uId = auth.currentUser!.uid;
      String? profileImageUrl;

      if (profileImage != null) {
        profileImageUrl = await ref
            .read(userFirebaseStorageRepositoryProvider)
            .storeFileToFirebase('userLogo/$uId', profileImage);
      }

      await firestore.collection('users').doc(uId).update({
        'name': name,
        'profileImage': profileImageUrl,
        'address': address,
      });

      Fluttertoast.showToast(msg: 'User profile updated successfully!');
    } on FirebaseAuthException catch (e) {
      Fluttertoast.showToast(msg: e.message!);
    }
  }

  Future<UserModel?> getUserDetails() async {
    var userData =
        await firestore.collection('users').doc(auth.currentUser!.uid).get();
    UserModel? user;
    if (userData.data() != null) {
      user = UserModel.fromMap(userData.data()!);
    }
    return user;
  }

  Future<List<BrandModel>> getBrandData() async {
    List<BrandModel> brandList = [];
    var allBrandData = await firestore.collection('brands').get();
    for (var document in allBrandData.docs) {
      var list = BrandModel.fromMap(document.data());
      brandList.add(list);
    }
    return brandList;
  }

  Future<List<ProductModel>> getDataByCollection({
    required String brandId,
    required String collection,
  }) async {
    List<ProductModel> productCollectionList = [];
    var allProductDataByCollection = await firestore
        .collection('brandProducts')
        .doc(brandId)
        .collection(collection)
        .get();
    for (var document in allProductDataByCollection.docs) {
      var list = ProductModel.fromMap(document.data());
      productCollectionList.add(list);
    }
    return productCollectionList;
  }

  Future<void> cartDataToFirebase({
    required BuildContext context,
    required String productId,
    required String productName,
    required String productImage,
    required String productPrice,
    required String productColor,
    required String productSize,
    required int orderQuantity,
    required String brandId,
    required String brandName,
    required ProviderRef ref,
  }) async {
    try {
      String uId = auth.currentUser!.uid;
      var totalOrderPrice = int.parse(productPrice) * orderQuantity;

      await firestore.collection('cart').doc(productId).set({
        'buyerId': uId,
        'brandId': brandId,
        'brandName': brandName,
        'productId': productId,
        'productName': productName,
        'productImage': productImage,
        'productPrice': productPrice,
        'productColor': productColor,
        'productSize': productSize,
        'orderQuantity': orderQuantity.toString(),
        'totalOrderPrice': totalOrderPrice.toString(),
      });

      Fluttertoast.showToast(msg: 'Product added to cart successfully!');
    } on FirebaseAuthException catch (e) {
      Fluttertoast.showToast(msg: e.message!);
    }
  }

  Future<List<CartModel>> getMyCartData() async {
    List<CartModel> myCartList = [];
    var allMyCartListData = await firestore
        .collection('cart')
        .where('buyerId', isEqualTo: auth.currentUser!.uid)
        .get();
    for (var document in allMyCartListData.docs) {
      var list = CartModel.fromMap(document.data());
      myCartList.add(list);
    }
    return myCartList;
  }

  Future<void> deleteMyCartData({required String productId}) async {
    try {
      await firestore.collection('cart').doc(productId).delete();
      Fluttertoast.showToast(msg: 'Product deleted successfully!');
    } catch (e) {
      Fluttertoast.showToast(msg: e.toString());
    }
  }

  Future<void> updateCartDataToFirebase({
    required BuildContext context,
    required String productId,
    required String productPrice,
    required int orderQuantity,
    required ProviderRef ref,
  }) async {
    try {
      var totalOrderPrice = int.parse(productPrice) * orderQuantity;

      await firestore.collection('cart').doc(productId).update({
        'productId': productId,
        'productPrice': productPrice,
        'orderQuantity': orderQuantity.toString(),
        'totalOrderPrice': totalOrderPrice.toString(),
      });
    } on FirebaseAuthException catch (e) {
      Fluttertoast.showToast(msg: e.message!);
    }
  }

  Future<List<ProductModel>> getAllBrandProductsData(
      {required String collection}) async {
    List<ProductModel> allProductsList = [];

    var brandData = await firestore
        .collection('allBrandProducts')
        .where('mainCategory', isEqualTo: collection)
        .get();
    for (var document in brandData.docs) {
      var list = ProductModel.fromMap(document.data());
      allProductsList.add(list);
    }
    return allProductsList;
  }

  Future<void> getSelectedProductOne({
    required String productName,
    required String productPrice,
    required String productSize,
    required String productImage,
    required String productColor,
  }) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setStringList(
      'productOneList',
      [
        productName,
        productPrice,
        productSize,
        productImage,
        productColor,
      ],
    );
  }

  Future<List<String>?> getSavedProductOne() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var list = prefs.getStringList('productOneList');
    return list;
  }

  Future<void> getSelectedProductTwo({
    required String productName,
    required String productPrice,
    required String productSize,
    required String productImage,
    required String productColor,
  }) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setStringList(
      'productTwoList',
      [
        productName,
        productPrice,
        productSize,
        productImage,
        productColor,
      ],
    );
  }

  Future<List<String>?> getSavedProductTwo() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var list = prefs.getStringList('productTwoList');
    return list;
  }
}
