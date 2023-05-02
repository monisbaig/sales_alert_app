import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sales_alert_app/user_directory/screens/bottom_navigator.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../common_component/loader.dart';
import '../auth/controller/user_auth_controller.dart';
import '../screens/edit_profile_page.dart';
import '../screens/my_orders.dart';

class UserNavBar extends ConsumerWidget {
  const UserNavBar({super.key});

  void signOut(BuildContext context, WidgetRef ref) {
    ref.read(userAuthControllerProvider).signOut(context);
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Drawer(
      child: ListView(
        // Remove padding
        padding: EdgeInsets.zero,
        children: [
          FutureBuilder(
            future: ref.watch(userAuthControllerProvider).getUserDetails(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Loader();
              }
              return UserAccountsDrawerHeader(
                accountName: Text(snapshot.data?.name ?? 'User Account'),
                accountEmail: Text(snapshot.data?.email ?? 'user@gmail.com'),
                currentAccountPicture: CircleAvatar(
                  child: ClipOval(
                    child: snapshot.data != null
                        ? Image.network(
                            snapshot.data!.profileImage,
                            fit: BoxFit.cover,
                            width: 90.w,
                            height: 90.h,
                          )
                        : Image.asset(
                            'lib/brands/brand_images/brand1.png',
                            fit: BoxFit.cover,
                            width: 90.w,
                            height: 90.h,
                          ),
                  ),
                ),
                decoration: const BoxDecoration(
                  color: Colors.blue,
                  image: DecorationImage(
                    fit: BoxFit.fill,
                    image: AssetImage('lib/common_images/nav_cart.PNG'),
                  ),
                ),
              );
            },
          ),
          GestureDetector(
            child: ListTile(
              leading: const Icon(Icons.favorite_sharp),
              title: const Text('Wishlist'),
              iconColor: const Color(0xFFDB3022),
              onTap: () => Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (_) => BottomNavigator(
                    selectPage: 1,
                  ),
                ),
              ),
            ),
          ),
          // GestureDetector(
          //   child: ListTile(
          //       leading: const Icon(Icons.notification_add_outlined),
          //       title: const Text('Notifications'),
          //       iconColor: const Color(0xFFDB3022),
          //       onTap: () => Navigator.of(context).push(
          //           MaterialPageRoute(builder: (_) => const Notifcations()))),
          // ),
          // GestureDetector(
          //   child: ListTile(
          //       leading: const Icon(Icons.chat),
          //       title: const Text('Live Chat'),
          //       iconColor: const Color(0xFFDB3022),
          //       onTap: () => Navigator.of(context)
          //           .push(MaterialPageRoute(builder: (_) => const LiveChat()))),
          // ),
          GestureDetector(
            child: ListTile(
                leading: const Icon(Icons.production_quantity_limits_rounded),
                title: const Text('My Orders'),
                iconColor: const Color(0xFFDB3022),
                onTap: () => Navigator.of(context)
                    .push(MaterialPageRoute(builder: (_) => const MyOrders()))),
          ),
          const Divider(
            thickness: 1,
            color: Color((0xFFDB3022)),
          ),
          GestureDetector(
            child: ListTile(
                leading: const Icon(Icons.settings),
                title: const Text('Settings'),
                iconColor: const Color(0xFFDB3022),
                onTap: () => Navigator.of(context).push(MaterialPageRoute(
                    builder: (_) => const EditProfilePage()))),
          ),
          ListTile(
            leading: const Icon(Icons.description),
            title: const Text('About Us'),
            iconColor: const Color(0xFFDB3022),
            onTap: () => null,
          ),
          const Divider(
            thickness: 1,
            color: Color((0xFFDB3022)),
          ),
          GestureDetector(
            child: ListTile(
              title: const Text('Log Out'),
              leading: const Icon(Icons.exit_to_app_outlined),
              iconColor: const Color(0xFFDB3022),
              onTap: () async {
                signOut(context, ref);
                SharedPreferences prefs = await SharedPreferences.getInstance();
                prefs.remove('productOneList');
                prefs.remove('productTwoList');
              },
            ),
          ),
          SizedBox(height: 60.h),
          const Center(
            child: Text(
              'Version: 2023\n  Sales Alert ®',
              style: TextStyle(
                color: Color(0xFFDB3022),
                fontSize: 12,
                fontFamily: 'RobotoMono',
                fontWeight: FontWeight.bold,
              ),
            ),
          )
        ],
      ),
    );
  }
}
