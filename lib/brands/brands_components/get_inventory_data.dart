import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sales_alert_app/Common_component/error_screen.dart';

import '../../Common_component/loader.dart';
import '../Screens/brand_details.dart';
import '../Screens/clothing/clothing_inventory.dart';
import '../Screens/electronics/electronics_inventory.dart';
import '../Screens/furniture/furniture_inventory.dart';
import '../auth/controller/brand_auth_controller.dart';

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
        if (snapshot.data == null) {
          return const ErrorScreen(
              error: 'Please enter your brand details first!');
        }
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
        return const BrandDetails();
      },
    );
  }
}
