import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sales_alert_app/brands/auth/repository/brand_auth_repository.dart';

import '../../models/brand_model.dart';

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

  void signInWithGoogle() {
    brandAuthRepository.signInWithGoogle();
  }

  void signOut() {
    brandAuthRepository.signOut();
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
}
