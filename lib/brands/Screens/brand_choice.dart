import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../brands_components/NavBar.dart';
import '../brands_components/brand_button.dart';
import 'View_Profile.dart';
import 'brand_details.dart';

class BrandChoice extends StatefulWidget {
  String id;
  BrandChoice({Key? key, required this.id}) : super(key: key);

  @override
  State<BrandChoice> createState() => _BrandChoiceState();
}

class _BrandChoiceState extends State<BrandChoice> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
      ),
      drawer: NavBar(),
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(height: 70.h),
            Center(
              child: Image.asset(
                'lib/Brand_directory/Brand_images/store.png',
                height: 220.h,
              ),
            ),
            SizedBox(height: 40.h),
            BrandButton(
              label: "Add details",
              onPress: () {
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (_) => BrandDetails()));
              },
            ),
            SizedBox(height: 20.h),
            Image.asset('lib/Brand_directory/Brand_images/profile.png',
                height: 220.h),
            BrandButton(
              label: "View Profile",
              onPress: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (_) => ViewBrandProfile(
                          id: widget.id,
                        )));
              },
            ),
          ],
        ),
      ),
    );
  }
}
