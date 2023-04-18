import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sales_alert_app/brands/models/brand_model.dart';

import '../../../brands/models/product_model.dart';
import '../../models/user_model.dart';
import '../repository/user_auth_repository.dart';

final userAuthControllerProvider = Provider((ref) {
  return UserAuthController(
    userAuthRepository: ref.watch(userAuthRepositoryProvider),
    ref: ref,
  );
});

final userDataAuthProvider = FutureProvider((ref) {
  final userAuthController = ref.watch(userAuthControllerProvider);
  return userAuthController.getUserData();
});

class UserAuthController {
  final UserAuthRepository userAuthRepository;
  final ProviderRef ref;

  UserAuthController({
    required this.userAuthRepository,
    required this.ref,
  });

  Future<UserModel?> getUserData() async {
    UserModel? user = await userAuthRepository.getCurrentUserData();
    return user;
  }

  Future<UserModel?> getUserDetails() async {
    return await userAuthRepository.getUserDetails();
  }

  void signUpWithEmail(
      BuildContext context, String name, String email, String password) {
    userAuthRepository.signUpWithEmail(
      context: context,
      name: name,
      email: email,
      password: password,
    );
  }

  void loginWithEmail(BuildContext context, String email, String password) {
    userAuthRepository.loginWithEmail(
      context: context,
      email: email,
      password: password,
    );
  }

  void signInWithGoogle(BuildContext context) async {
    await userAuthRepository.signInWithGoogle(context: context);
  }

  void signOut(BuildContext context) {
    userAuthRepository.signOut(context: context);
  }

  void updateUserDataToFirebase(
      BuildContext context, String name, String address, File? profileImage) {
    userAuthRepository.updateUserDataToFirebase(
      context: context,
      name: name,
      address: address,
      profileImage: profileImage,
      ref: ref,
    );
  }

  Future<List<BrandModel>> getBrandData() {
    return userAuthRepository.getBrandData();
  }

  Future<List<SubCategoryDetail>> getDataByCollection(
      String brandId, String collection) {
    return userAuthRepository.getDataByCollection(
      brandId: brandId,
      collection: collection,
    );
  }

  Future<void> cartDataToFirebase(
    BuildContext context,
    String productId,
    String productName,
    String productImage,
    String productPrice,
    String productColor,
    String productSize,
    String brandId,
    String brandName,
  ) {
    return userAuthRepository.cartDataToFirebase(
      context: context,
      productId: productId,
      productName: productName,
      productImage: productImage,
      productPrice: productPrice,
      productColor: productColor,
      productSize: productSize,
      brandId: brandId,
      brandName: brandName,
      ref: ref,
    );
  }
}
