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
import 'package:sales_alert_app/brands/models/product_model.dart';
import 'package:sales_alert_app/splash/splash_screen.dart';

import '../../../user_directory/models/order_place_model.dart';
import '../../Screens/brand_choice.dart';
import '../../Screens/brand_login_page.dart';
import '../../Screens/brand_success.dart';

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
        Fluttertoast.showToast(msg: 'Verify Email First');
      } else {
        Fluttertoast.showToast(msg: 'Logged in successfully');

        Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(
            builder: (context) => const BrandChoice(),
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
        UserCredential brandCredential =
            await auth.signInWithCredential(credential);
        Fluttertoast.showToast(msg: brandCredential.user!.email!);

        Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(
            builder: (context) => const BrandChoice(),
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
    } on FirebaseAuthException catch (e) {
      Fluttertoast.showToast(msg: e.message!);
    }
  }

  Future<void> saveCategoryDataToFirebase({
    BuildContext? context,
    String? mainCategory,
    String? subCategory,
    String? name,
    String? price,
    File? photo,
    String? color,
    String? quantity,
    String? description,
    String? size,
    ProviderRef? ref,
  }) async {
    try {
      String uId = auth.currentUser!.uid;
      String? productPhotoUrl;
      var uniqueId = DateTime.now().millisecondsSinceEpoch.toString();

      if (photo != null) {
        productPhotoUrl = await ref!
            .read(brandFirebaseStorageRepositoryProvider)
            .storeFileToFirebase('productPhoto/$uId/$uniqueId', photo);
      }

      var productDetail = ProductModel(
        mainCategory: mainCategory!,
        productId: uniqueId,
        brandId: auth.currentUser!.uid,
        category: subCategory!,
        name: name!,
        price: price!,
        photo: productPhotoUrl!,
        color: color!,
        quantity: quantity!,
        description: description!,
        size: size!,
      );

      await firestore
          .collection('brandProducts')
          .doc(uId)
          .collection(mainCategory)
          .doc(uniqueId)
          .set(productDetail.toMap());

      await firestore
          .collection('allBrandProducts')
          .doc(uniqueId)
          .set(productDetail.toMap());

      Fluttertoast.showToast(msg: 'Product saved successfully!');

      Navigator.pushAndRemoveUntil(
        context!,
        MaterialPageRoute(
          builder: (context) => const BrandSuccess(
            label: 'Your item is successfully added to the Store',
          ),
        ),
        (route) => false,
      );
    } on FirebaseAuthException catch (e) {
      Fluttertoast.showToast(msg: e.message!);
    }
  }

  Future<List<ProductModel>> getCollectionData(String collection) async {
    List<ProductModel> subCategoryList = [];
    var brandProductData = await firestore
        .collection('brandProducts')
        .doc(auth.currentUser!.uid)
        .collection(collection)
        .get();
    ProductModel? subCategoryDetail;
    for (var document in brandProductData.docs) {
      subCategoryDetail = ProductModel.fromMap(document.data());
      subCategoryList.add(subCategoryDetail);
    }
    subCategoryList = subCategoryList;
    return subCategoryList;
  }

  Future<BrandModel?> getCategoryData() async {
    var brandData =
        await firestore.collection('brands').doc(auth.currentUser!.uid).get();
    BrandModel? brand;
    if (brandData.data() != null) {
      brand = BrandModel.fromMap(brandData.data()!);
    }
    return brand;
  }

  Future<void> deleteItemById({
    required BuildContext context,
    required String collection,
    required String productId,
  }) async {
    try {
      await firestore
          .collection('brandProducts')
          .doc(auth.currentUser!.uid)
          .collection(collection)
          .doc(productId)
          .delete();
      Fluttertoast.showToast(msg: 'Product deleted successfully!');
      Navigator.of(context).pop();
    } catch (e) {
      Fluttertoast.showToast(msg: e.toString());
    }
  }

  Future<void> updateCategoryDataToFirebase({
    BuildContext? context,
    String? collection,
    String? name,
    String? price,
    String? uniqueId,
    String? quantity,
    String? description,
    ProviderRef? ref,
  }) async {
    try {
      String uId = auth.currentUser!.uid;
      String? productPhotoUrl;

      // if (photo != null) {
      //   productPhotoUrl = await ref!
      //       .read(brandFirebaseStorageRepositoryProvider)
      //       .storeFileToFirebase('productPhoto/$uId/$uniqueId', photo);
      // }

      await firestore
          .collection('brandProducts')
          .doc(uId)
          .collection(collection!)
          .doc(uniqueId)
          .update({
        'name': name,
        'price': price,
        // 'photo': productPhotoUrl,
        'quantity': quantity,
        'description': description,
      });

      Fluttertoast.showToast(msg: 'Product updated successfully!');

      Navigator.of(context!).pop();
    } on FirebaseAuthException catch (e) {
      Fluttertoast.showToast(msg: e.message!);
    }
  }

  Future<List<OrderPlaceModel>> getOrderPlacedData() async {
    List<OrderPlaceModel> myOrderList = [];
    var allMyOrderListData = await firestore
        .collection('confirmOrders')
        .where('brandId', isEqualTo: auth.currentUser!.uid)
        .get();

    for (var element in allMyOrderListData.docs) {
      myOrderList.add(
        OrderPlaceModel(
          buyerId: element['buyerId'],
          brandId: element['brandId'],
          orderDate: DateTime.parse(element['orderDate']),
          orderStatus: element['orderStatus'],
          paymentMethod: element['paymentMethod'],
          deliveryCharges: element['deliveryCharges'],
          totalAmount: element['totalAmount'],
          products: (element['products'] as List<dynamic>)
              .map(
                (item) => Products(
                  brandId: item['brandId'],
                  buyerId: item['buyerId'],
                  buyerName: item['buyerName'],
                  productId: item['productId'],
                  productName: item['productName'],
                  productImage: item['productImage'],
                  productPrice: item['productPrice'],
                  productColor: item['productColor'],
                  productSize: item['productSize'],
                  orderQuantity: item['orderQuantity'],
                  totalOrderPrice: item['totalOrderPrice'],
                ),
              )
              .toList(),
        ),
      );
    }

    return myOrderList;
  }
}
