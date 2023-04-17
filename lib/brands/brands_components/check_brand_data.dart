import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sales_alert_app/brands/Screens/brand_saved_details.dart';

import '../../Common_component/loader.dart';
import '../Screens/brand_details.dart';
import '../auth/controller/brand_auth_controller.dart';

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
