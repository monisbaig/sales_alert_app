import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../common_component/loader.dart';
import '../auth/controller/brand_auth_controller.dart';
import '../screens/brand_details.dart';
import '../screens/clothing/clothing_categories.dart';
import '../screens/electronics/electronics_categories.dart';
import '../screens/furniture/furniture_categories.dart';

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
        if (snapshot.data != null) {
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
        }
        return const BrandDetails();
      },
    );
  }
}
