import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sales_alert_app/user_directory/models/order_place_model.dart';

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

  void sendPasswordResetRequest(String email) {
    userAuthRepository.sendPasswordResetRequest(email: email);
  }

  void loginWithEmail(BuildContext context, String email, String password) {
    userAuthRepository.loginWithEmail(
      context: context,
      email: email,
      password: password,
      ref: ref,
    );
  }

  void signInWithGoogle(BuildContext context) async {
    await userAuthRepository.signInWithGoogle(context: context, ref: ref);
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

  Future<List<ProductModel>> getDataByCategory(String category) {
    return userAuthRepository.getDataByCategory(category: category);
  }

  Future<void> cartDataToFirebase(
    BuildContext context,
    String productId,
    String productName,
    String productImage,
    String productPrice,
    String productColor,
    String productSize,
    String orderQuantity,
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
    String productId,
    String productName,
    String productPrice,
    String productDescription,
    String productImage,
    String productColor,
  ) {
    return userAuthRepository.getSelectedProductOne(
      productId: productId,
      productName: productName,
      productPrice: productPrice,
      productDescription: productDescription,
      productColor: productColor,
      productImage: productImage,
    );
  }

  Future<List<String>?> getSavedProductOne() {
    return userAuthRepository.getSavedProductOne();
  }

  Future<void> getSelectedProductTwo(
    String productId,
    String productName,
    String productPrice,
    String productDescription,
    String productImage,
    String productColor,
  ) {
    return userAuthRepository.getSelectedProductTwo(
      productId: productId,
      productName: productName,
      productPrice: productPrice,
      productDescription: productDescription,
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

  Future<void> followProduct(
    String brandId,
    String productId,
    String productName,
  ) {
    return userAuthRepository.followProduct(
      brandId: brandId,
      productId: productId,
      productName: productName,
      ref: ref,
    );
  }

  Stream<bool> getFollowingProductData(String brandId) {
    return userAuthRepository.getFollowingProductData(brandId: brandId);
  }

  Future<void> unFollowProduct(String brandId) {
    return userAuthRepository.unFollowProduct(brandId: brandId, ref: ref);
  }

  Future<void> fetchAndSaveOrderPlacedData(
    String buyerName,
    String brandId,
    String buyerAddress,
    String paymentMethod,
    String totalAmount,
  ) {
    return userAuthRepository.fetchAndSaveOrderPlacedData(
      buyerName: buyerName,
      brandId: brandId,
      buyerAddress: buyerAddress,
      paymentMethod: paymentMethod,
      totalAmount: totalAmount,
      ref: ref,
    );
  }

  Future<List<OrderPlaceModel>> getOrderPlacedData() {
    return userAuthRepository.getOrderPlacedData();
  }

  Future<void> productRating(
    String brandId,
    String buyerId,
    String productId,
    double productRating,
  ) {
    return userAuthRepository.productRating(
      brandId: brandId,
      buyerId: buyerId,
      productId: productId,
      productRating: productRating,
    );
  }

  Stream<double> getProductRatingData(String productId) {
    return userAuthRepository.getProductRatingData(productId: productId);
  }
}
