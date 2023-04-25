// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:line_icons/line_icons.dart';
import 'package:sales_alert_app/user_directory/screens/favourites_screen.dart';

import 'cart_screen.dart';
import 'compare_products.dart';
import 'edit_profile_page.dart';
import 'home_screen.dart';

class BottomNavigator extends StatefulWidget {
  int selectPage;
  BottomNavigator({super.key, this.selectPage = 0});

  @override
  State<BottomNavigator> createState() => _BottomNavigatorState();
}

class _BottomNavigatorState extends State<BottomNavigator> {
  static List<Widget> widgetOptions = <Widget>[
    const HomeScreen(),
    const FavouritesScreen(),
    const CartScreen(),
    const CompareProducts(),
    const EditProfilePage(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: widgetOptions.elementAt(widget.selectPage),
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
              padding: const EdgeInsets.symmetric(horizontal: 17, vertical: 8),
              child: GNav(
                rippleColor: Colors.grey[300]!,
                hoverColor: Colors.grey[100]!,
                gap: 2,
                activeColor: Colors.white,
                iconSize: 19,
                padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 12.h),
                duration: const Duration(milliseconds: 400),
                tabBackgroundColor: Colors.redAccent,
                color: Colors.black,
                tabs: const [
                  GButton(icon: LineIcons.home, text: 'Home'),
                  GButton(icon: LineIcons.heart, text: 'Favorites'),
                  GButton(icon: LineIcons.shoppingCart, text: 'Cart'),
                  GButton(icon: Icons.swap_horiz_rounded, text: 'Compare'),
                  GButton(icon: Icons.person, text: 'Profile')
                ],
                selectedIndex: widget.selectPage,
                onTabChange: (index) {
                  setState(() {
                    widget.selectPage = index;
                  });
                },
              ),
            ),
          ),
        ));
  }
}
