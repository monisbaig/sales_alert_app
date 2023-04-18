import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:line_icons/line_icons.dart';

import 'cart_screen.dart';
import 'compare_products.dart';
import 'edit_profile_page.dart';
import 'home_screen.dart';

class BottomNavigator extends StatefulWidget {
  const BottomNavigator({super.key});

  @override
  State<BottomNavigator> createState() => _BottomNavigatorState();
}

class _BottomNavigatorState extends State<BottomNavigator> {
  int _selectedIndex = 0;
  static List<Widget> widgetOptions = <Widget>[
    const HomeScreen(),
    CartScreen(),
    const Compare(),
    EditProfilePage(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: widgetOptions.elementAt(_selectedIndex),
        bottomNavigationBar: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                blurRadius: 20,
                color: Colors.black.withOpacity(0.1),
              ),
            ],
          ),
          child: SafeArea(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 15, vertical: 8),
              child: GNav(
                rippleColor: Colors.grey[300]!,
                hoverColor: Colors.grey[100]!,
                gap: 8,
                activeColor: Colors.white,
                iconSize: 25,
                padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 12.h),
                duration: const Duration(milliseconds: 400),
                tabBackgroundColor: Colors.redAccent,
                color: Colors.black,
                tabs: const [
                  GButton(icon: LineIcons.home, text: 'Home'),
                  GButton(icon: LineIcons.shoppingCart, text: 'Cart'),
                  GButton(icon: Icons.swap_horiz_rounded, text: 'Compare'),
                  GButton(icon: Icons.person, text: 'Profile')
                ],
                selectedIndex: _selectedIndex,
                onTabChange: (index) {
                  setState(() {
                    _selectedIndex = index;
                  });
                },
              ),
            ),
          ),
        ));
  }
}