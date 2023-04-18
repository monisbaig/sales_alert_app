// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
//
// import '../../Common_component/loader.dart';
// import '../../brands/auth/controller/brand_auth_controller.dart';
// import '../auth/controller/user_auth_controller.dart';
//
// class GetStoreData extends ConsumerWidget {
//   const GetStoreData({super.key});
//
//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     return FutureBuilder(
//       future: ref.watch(userAuthControllerProvider).getBrandData(),
//       builder: (context, snapshot) {
//         if (snapshot.connectionState == ConnectionState.waiting) {
//           return const Loader();
//         }
//         if (snapshot.data != null) {
//
//           if (categoryData == 'Clothing') {
//             return const ClothingCategories();
//           }
//           if (categoryData == 'Electronics') {
//             return const ElectronicsCategories();
//           }
//           if (categoryData == 'Furniture') {
//             return const FurnitureCategories();
//           }
//         }
//         return const BrandDetails();
//       },
//     );
//   }
// }
