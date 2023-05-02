import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sales_alert_app/brands/screens/brand_saved_details.dart';

import '../../common_component/loader.dart';
import '../auth/controller/brand_auth_controller.dart';
import '../screens/brand_details.dart';

class CheckBrandData extends ConsumerWidget {
  const CheckBrandData({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return FutureBuilder(
      future: ref.watch(brandAuthControllerProvider).getCategoryData(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Loader();
        }
        if (snapshot.data != null) {
          return const BrandSavedDetails();
        }
        return const BrandDetails();
      },
    );
  }
}
