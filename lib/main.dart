import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sales_alert_app/splash/splash_screen.dart';

import 'firebase_options.dart';

@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  runApp(
    const ProviderScope(
      child: MyApp(),
    ),
  );
}

bool? isCheck;

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ScreenUtilInit(
      designSize: const Size(393, 851),
      builder: (BuildContext context, child) => const MaterialApp(
        debugShowCheckedModeBanner: false,
        home: SplashScreen(),
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

// ref.watch(userDataAuthProvider).when(
// data: (user) {
// if (user == null) {
// return const Splash();
// }
// return BottomNavigator();
// },
// error: (error, stackTrace) {
// return ErrorScreen(
// error: error.toString(),
// );
// },
// loading: () => const Loader(),
// ),
