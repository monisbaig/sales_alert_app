import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';

import '../../../Common_component/my_button.dart';
import '../Brand_Success.dart';

class add_eimage extends StatefulWidget {
  const add_eimage({super.key});
  @override
  State<add_eimage> createState() => add_imageState();
}

class add_imageState extends State<add_eimage> {
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
                  color: const Color.fromRGBO(217, 217, 217, 1),
                ),
                child: Container(
                  margin:
                      EdgeInsets.symmetric(horizontal: 70.w, vertical: 20.h),
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: Color(0xFFDB3022),
                  ),
                  child: GestureDetector(
                    child: const Icon(
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
                            builder: (context) => success(
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
