import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sales_alert_app/brands/auth/repository/brand_auth_repository.dart';

import '../../models/brand_model.dart';
import '../../models/product_model.dart';

final brandAuthControllerProvider = Provider((ref) {
  return BrandAuthController(
    brandAuthRepository: ref.watch(brandAuthRepositoryProvider),
    ref: ref,
  );
});

final brandDataAuthProvider = FutureProvider((ref) {
  final brandAuthController = ref.watch(brandAuthControllerProvider);
  return brandAuthController.getBrandData();
});

class BrandAuthController {
  final BrandAuthRepository brandAuthRepository;
  final ProviderRef ref;

  BrandAuthController({
    required this.brandAuthRepository,
    required this.ref,
  });

  Future<BrandModel?> getBrandData() async {
    BrandModel? brand = await brandAuthRepository.getCurrentBrandData();
    return brand;
  }

  Future<List<ProductModel>> getCollectionData(String collection) async {
    List<ProductModel> subCategoryDetail =
        await brandAuthRepository.getCollectionData(collection);

    return subCategoryDetail;
  }

  void signUpWithEmail(BuildContext context, String email, String password) {
    brandAuthRepository.signUpWithEmail(
      context: context,
      email: email,
      password: password,
    );
  }

  void loginWithEmail(BuildContext context, String email, String password) {
    brandAuthRepository.loginWithEmail(
      context: context,
      email: email,
      password: password,
    );
  }

  void signInWithGoogle(BuildContext context) async {
    await brandAuthRepository.signInWithGoogle(context: context);
  }

  void signOut(BuildContext context) {
    brandAuthRepository.signOut(context: context);
  }

  void saveBrandDataToFirebase(
      BuildContext context, String name, File? logo, String category) {
    brandAuthRepository.saveBrandDataToFirebase(
      context: context,
      name: name,
      logo: logo,
      category: category,
      ref: ref,
    );
  }

  void saveCategoryDataToFirebase(
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
  ) {
    brandAuthRepository.saveCategoryDataToFirebase(
      context: context,
      mainCategory: mainCategory,
      subCategory: subCategory,
      name: name,
      price: price,
      photo: photo,
      color: color,
      quantity: quantity,
      description: description,
      size: size,
      ref: ref,
    );
  }

  void updateCategoryDataToFirebase(
    BuildContext? context,
    String? collection,
    String? productId,
    String? name,
    String? price,
    String? quantity,
    String? description,
  ) {
    brandAuthRepository.updateCategoryDataToFirebase(
      context: context,
      collection: collection,
      uniqueId: productId,
      name: name,
      price: price,
      quantity: quantity,
      description: description,
      ref: ref,
    );
  }

  Future<BrandModel?> getCategoryData() async {
    return await brandAuthRepository.getCategoryData();
  }

  Future<void> deleteItemById(
      BuildContext context, String collection, String productId) async {
    return await brandAuthRepository.deleteItemById(
      context: context,
      collection: collection,
      productId: productId,
    );
  }
}
