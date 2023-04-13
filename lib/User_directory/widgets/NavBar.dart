import 'package:flutter/material.dart';

import '../screens/edit_screen.dart';
import '../screens/favourites.dart';
import '../screens/live_chat.dart';
import '../screens/my_orders.dart';
import '../screens/notification.dart';

class NavBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        // Remove padding
        padding: EdgeInsets.zero,
        children: [
          const UserAccountsDrawerHeader(
            accountName: Text('Salman Baig'),
            accountEmail: Text('salman@gmail.com'),
            decoration: BoxDecoration(
              color: Colors.blue,
              image: DecorationImage(
                  fit: BoxFit.fill,
                  image: AssetImage('lib/Common_images/nav_cart.PNG')),
            ),
          ),
          GestureDetector(
            child: ListTile(
                leading: const Icon(Icons.favorite_sharp),
                title: const Text('Wishlist'),
                iconColor: const Color(0xFFDB3022),
                onTap: () => Navigator.of(context)
                    .push(MaterialPageRoute(builder: (_) => Favourites()))),
          ),
          GestureDetector(
            child: ListTile(
                leading: const Icon(Icons.notification_add_outlined),
                title: const Text('Notifications'),
                iconColor: const Color(0xFFDB3022),
                onTap: () => Navigator.of(context).push(
                    MaterialPageRoute(builder: (_) => const Notifcations()))),
          ),
          GestureDetector(
            child: ListTile(
                leading: const Icon(Icons.chat),
                title: const Text('Live Chat'),
                iconColor: const Color(0xFFDB3022),
                onTap: () => Navigator.of(context)
                    .push(MaterialPageRoute(builder: (_) => const LiveChat()))),
          ),
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
                onTap: () => Navigator.of(context).push(
                    MaterialPageRoute(builder: (_) => EditProfilePage()))),
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
              onTap: () => null,
            ),
          ),
          const Padding(
            padding: EdgeInsets.all(105.0),
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
