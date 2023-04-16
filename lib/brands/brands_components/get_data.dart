import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../Common_component/error_screen.dart';
import '../../Common_component/loader.dart';
import '../Screens/brand_details.dart';
import '../Screens/clothing/clothing_categories.dart';
import '../Screens/electronics/electronics_categories.dart';
import '../Screens/furniture/furniture_categories.dart';
import '../auth/controller/brand_auth_controller.dart';

class GetData extends ConsumerWidget {
  const GetData({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return FutureBuilder(
      future: ref.watch(brandAuthControllerProvider).getCategoryData(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Loader();
        }
        if (snapshot.data == null) {
          return const ErrorScreen(
            error: 'Please enter your brand details first!',
          );
        }
        var categoryData = snapshot.data!.category;
        if (categoryData == 'Clothing') {
          return const ClothingCategories();
        }
        if (categoryData == 'Electronics') {
          return const ElectronicsCategories();
        }
        if (categoryData == 'Furniture') {
          return const FurnitureCategories();
        }
        return const BrandDetails();
      },
    );
  }
}
