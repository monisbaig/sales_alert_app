import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sales_alert_app/Common_component/error_screen.dart';
import 'package:sales_alert_app/User_directory/screens/bottom_navigator.dart';
import 'package:sales_alert_app/splash/splash_screen.dart';

import 'Common_component/loader.dart';
import 'User_directory/auth/controller/user_auth_controller.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(
    const ProviderScope(
      child: MyApp(),
    ),
  );
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ScreenUtilInit(
      designSize: const Size(393, 851),
      builder: (BuildContext context, child) => MaterialApp(
        debugShowCheckedModeBanner: false,
        home: ref.watch(userDataAuthProvider).when(
              data: (user) {
                if (user == null) {
                  return const Splash();
                }
                return BottomNavigator();
              },
              error: (error, stackTrace) {
                return ErrorScreen(
                  error: error.toString(),
                );
              },
              loading: () => const Loader(),
            ),
        //ChooseScreen(),
      ),
    );
  }
}

// ref.watch(brandDataAuthProvider).when(
// data: (brand) {
// if (brand == null) {
// return const Splash();
// }
// return const BrandChoice();
// },
// error: (error, stackTrace) {
// return ErrorScreen(
// error: error.toString(),
// );
// },
// loading: () => const Loader(),
// ),
