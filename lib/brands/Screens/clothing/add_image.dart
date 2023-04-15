import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';

import '../../../Common_component/my_button.dart';
import '../../../User_directory/screens/user_success.dart';

class add_image extends StatefulWidget {
  const add_image({super.key});
  @override
  State<add_image> createState() => add_imageState();
}

class add_imageState extends State<add_image> {
  XFile? image;

  Future getImage(ImageSource source) async {
    ImagePicker imagepicker = ImagePicker();
    final image = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (image == null) return;

    final imagetemp = XFile(image.path);

    setState(() {
      this.image = imagetemp;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Center(
          child: Column(
            children: [
              SizedBox(height: 100.h),
              Container(
                child: Text(
                  'Add photos ',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 40.sp,
                  ),
                ),
              ),
              SizedBox(height: 120.h),
              Container(
                height: 250.h,
                width: 230.w,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Color.fromRGBO(217, 217, 217, 1),
                ),
                child: Container(
                  margin:
                      EdgeInsets.symmetric(horizontal: 70.w, vertical: 20.h),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Color(0xFFDB3022),
                  ),
                  child: GestureDetector(
                    child: Icon(
                      Icons.camera_alt,
                      size: 50,
                      color: Colors.white,
                    ),
                    onTap: () => getImage(ImageSource.gallery),
                  ),
                ),
              ),
              SizedBox(height: 100.h),
              Container(
                child: Text(
                  'Add Product photos ',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 35.sp,
                  ),
                ),
              ),
              SizedBox(height: 80.h),
              MyButton(
                  label: 'Done',
                  onPress: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => Success(
                                label:
                                    'Your item is successfully added to the Store')));
                  })
            ],
          ),
        ),
      ),
    );
  }
}
