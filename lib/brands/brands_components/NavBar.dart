import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../Screens/Account_Details.dart';
import '../Screens/Add_Products.dart';
import '../Screens/Request.dart';
import '../Screens/View_Orders.dart';
// import '../Screens/inventory/inventory.dart';

class NavBar extends StatelessWidget {
  const NavBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        // Remove padding
        padding: EdgeInsets.zero,
        children: [
          UserAccountsDrawerHeader(
            accountName: const Text('Oflutter.com'),
            accountEmail: const Text('example@gmail.com'),
            currentAccountPicture: CircleAvatar(
              child: ClipOval(
                child: Image.asset(
                  'lib/Brand_directory/Brand_images/brand1.png',
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
                  image: AssetImage('lib/Common_images/nav_cart.PNG')),
            ),
          ),
          GestureDetector(
            child: ListTile(
              leading: const Icon(Icons.inventory_outlined),
              title: const Text('Check Inventory'),
              iconColor: const Color(0xFFDB3022),
              onTap: () {},
              //  =>Navigator.of(context).push(MaterialPageRoute(builder: (_)=> const inventory())),
            ),
          ),
          ListTile(
            leading: const Icon(Icons.add_business_outlined),
            title: const Text('Add Products'),
            iconColor: const Color(0xFFDB3022),
            onTap: () => Navigator.of(context).push(MaterialPageRoute(
                builder: (_) => AddProducts(
                      id: "555",
                    ))),
          ),
          ListTile(
            leading: const Icon(Icons.production_quantity_limits_rounded),
            title: const Text('View Orders'),
            iconColor: const Color(0xFFDB3022),
            onTap: () => Navigator.of(context)
                .push(MaterialPageRoute(builder: (_) => ViewOrders())),
          ),
          ListTile(
            leading: const Icon(Icons.notifications),
            title: const Text('Request'),
            iconColor: const Color(0xFFDB3022),
            onTap: () => Navigator.of(context)
                .push(MaterialPageRoute(builder: (_) => const Request())),
          ),
          const Divider(
            thickness: 1,
            color: Color((0xFFDB3022)),
          ),
          ListTile(
            leading: const Icon(Icons.settings),
            title: const Text('Settings'),
            iconColor: const Color(0xFFDB3022),
            onTap: () => Navigator.of(context).push(
                MaterialPageRoute(builder: (_) => const AccountDetails())),
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
          ListTile(
            title: const Text('Log Out'),
            leading: const Icon(Icons.exit_to_app_outlined),
            iconColor: const Color(0xFFDB3022),
            onTap: () => null,
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
