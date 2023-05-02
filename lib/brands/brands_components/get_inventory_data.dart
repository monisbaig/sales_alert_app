import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../common_component/loader.dart';
import '../auth/controller/brand_auth_controller.dart';
import '../screens/brand_details.dart';
import '../screens/clothing/clothing_inventory.dart';
import '../screens/electronics/electronics_inventory.dart';
import '../screens/furniture/furniture_inventory.dart';

class GetInventoryData extends ConsumerWidget {
  const GetInventoryData({super.key});

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
            return const ClothingInventory();
          }
          if (categoryData == 'Electronics') {
            return const ElectronicsInventory();
          }
          if (categoryData == 'Furniture') {
            return const FurnitureInventory();
          }
        }
        return const BrandDetails();
      },
    );
  }
}
