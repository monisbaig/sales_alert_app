import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../brands/models/brand_model.dart';
import '../../../brands/models/product_model.dart';
import '../../models/cart_model.dart';
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

  Future<List<ProductModel>> getDataByCollection(
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
    int orderQuantity,
    String brandId,
  ) {
    return userAuthRepository.cartDataToFirebase(
      context: context,
      productId: productId,
      productName: productName,
      productImage: productImage,
      productPrice: productPrice,
      productColor: productColor,
      productSize: productSize,
      orderQuantity: orderQuantity,
      brandId: brandId,
      ref: ref,
    );
  }

  Future<List<CartModel>> getMyCartData() {
    return userAuthRepository.getMyCartData();
  }

  Future<void> deleteMyCartData(String productId) {
    return userAuthRepository.deleteMyCartData(productId: productId);
  }

  Future<void> updateCartDataToFirebase(
    BuildContext context,
    String productId,
    String productPrice,
    int orderQuantity,
  ) {
    return userAuthRepository.updateCartDataToFirebase(
      context: context,
      productId: productId,
      productPrice: productPrice,
      orderQuantity: orderQuantity,
      ref: ref,
    );
  }

  Future<List<ProductModel>> getAllBrandProductsData(String collection) {
    return userAuthRepository.getAllBrandProductsData(collection: collection);
  }

  Future<List<ProductModel>> searchAllBrandProducts() {
    return userAuthRepository.searchAllBrandProducts();
  }

  Future<void> getSelectedProductOne(
    String productName,
    String productPrice,
    String productSize,
    String productImage,
    String productColor,
  ) {
    return userAuthRepository.getSelectedProductOne(
      productName: productName,
      productPrice: productPrice,
      productSize: productSize,
      productColor: productColor,
      productImage: productImage,
    );
  }

  Future<List<String>?> getSavedProductOne() {
    return userAuthRepository.getSavedProductOne();
  }

  Future<void> getSelectedProductTwo(
    String productName,
    String productPrice,
    String productSize,
    String productImage,
    String productColor,
  ) {
    return userAuthRepository.getSelectedProductTwo(
      productName: productName,
      productPrice: productPrice,
      productSize: productSize,
      productColor: productColor,
      productImage: productImage,
    );
  }

  Future<List<String>?> getSavedProductTwo() {
    return userAuthRepository.getSavedProductTwo();
  }

  Future<void> saveFavoritesToFirebase(
    BuildContext context,
    String productId,
    String productName,
    String productImage,
    String productPrice,
    String productColor,
    String productSize,
    int orderQuantity,
    String brandId,
  ) {
    return userAuthRepository.saveFavoritesToFirebase(
      context: context,
      productId: productId,
      productName: productName,
      productImage: productImage,
      productPrice: productPrice,
      productColor: productColor,
      productSize: productSize,
      orderQuantity: orderQuantity,
      brandId: brandId,
      ref: ref,
    );
  }

  Future<List<CartModel>> getFavoritesData() {
    return userAuthRepository.getFavoritesData();
  }

  Future<void> deleteMyFavoritesData(String productId) {
    return userAuthRepository.deleteMyFavoritesData(productId: productId);
  }

  Future<void> followBrand(String brandId, String brandName) {
    return userAuthRepository.followBrand(
      brandId: brandId,
      brandName: brandName,
      ref: ref,
    );
  }

  Stream<bool> getFollowingData(String brandId) {
    return userAuthRepository.getFollowingData(brandId: brandId);
  }

  Future<void> unFollowBrand(String brandId) {
    return userAuthRepository.unFollowBrand(brandId: brandId, ref: ref);
  }
}
