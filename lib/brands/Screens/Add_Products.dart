import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:image_picker/image_picker.dart';

class AddProducts extends StatefulWidget {
  String id;
  AddProducts({Key? key, required this.id}) : super(key: key);

  @override
  State<AddProducts> createState() => _AddProductsState();
}

class _AddProductsState extends State<AddProducts> {
  TextEditingController title = TextEditingController();
  TextEditingController price = TextEditingController();
  TextEditingController oldPrice = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  ///Image Picker
  File? image;
  bool isimagepick = false;
  final _picker = ImagePicker();
  Future getimage() async {
    final pickedfile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedfile != null) {
      setState(() {
        image = File(pickedfile.path);
        isimagepick = true;
        print(image);
      });
    } else {
      print("Not any image is selected");
    }
  }

  bool isloading = false;

  ///Submit
  submit() async {
    setState(() {
      isloading = true;
    });
    var pathimage = image!.path;
    var temp = pathimage.lastIndexOf("/");
    var result = pathimage.substring(temp + 1);
    print(result);
    final ref = FirebaseStorage.instance.ref("images").child(result);
    var response = await ref.putFile(image!);
    print("updaated $response");
    var imageurl = await ref.getDownloadURL();

    try {
      // var response =
      //     await FirebaseFirestore.instance.collection("brandsImages").add({
      // "image": imageurl,
      // "title": title.text,
      // "price": price.text,
      // "old": oldPrice.text,
      // });
      await FirebaseFirestore.instance.collection("brands").doc(widget.id).set({
        'user_Id': widget.id,
        'joinDate': DateTime.now().millisecondsSinceEpoch,
        "image": imageurl,
        "title": title.text,
        "price": price.text,
        "old": oldPrice.text,
      });
      await ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text("Added Successfully"),
        backgroundColor: Colors.green,
        behavior: SnackBarBehavior.floating,
      ));
      setState(() {
        isloading = false;
      });
      // Navigator.pushAndRemoveUntil(
      //   context,
      //   MaterialPageRoute(
      //     builder: (BuildContext context) => Dashboard(),
      //   ),
      //   (route) => false,
      // );

      // snackbar(
      //   "Successfully Submit",
      //   "",
      //   snackPosition: SnackPosition.BOTTOM,
      // );

      print("Done Susscessfullt");
    } catch (exception) {
      print("Error Saving Data at firestore $exception");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff3c83f1),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: const Color(0xff3c83f1),
        title: const Text("Upload Product"),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back_ios),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 5),
          child: Container(
            margin: const EdgeInsets.all(22),
            padding: const EdgeInsets.all(22),
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(12)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 20,
                ),
                Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 30,
                      ),
                      Stack(
                        children: [
                          InkWell(
                            onTap: () {
                              getimage();
                            },
                            child: Container(
                              height: 200,
                              width: 300,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(color: Colors.grey),
                              ),
                              child: image == null
                                  ? InkWell(
                                      onTap: () {
                                        getimage();
                                      },
                                      child: const Icon(
                                        Icons.camera_alt,
                                      ),
                                    )
                                  : Image.file(
                                      File(image!.path).absolute,
                                      // height: 100,
                                      // width: 100,
                                      fit: BoxFit.fill,
                                    ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      TextFormField(
                        controller: title,
                        validator:
                            RequiredValidator(errorText: "Title is required"),
                        decoration: const InputDecoration(
                          contentPadding: EdgeInsets.symmetric(
                              horizontal: 20, vertical: 20),
                          floatingLabelBehavior: FloatingLabelBehavior.always,
                          border: OutlineInputBorder(),
                          prefix: SizedBox(
                            width: 10,
                          ),
                          labelText: "Title",
                          hintText: "Enter Title",
                        ),
                      ),
                      const SizedBox(height: 20),
                      TextFormField(
                        controller: price,
                        keyboardType: TextInputType.phone,
                        validator: RequiredValidator(errorText: "price"),
                        decoration: const InputDecoration(
                          contentPadding: EdgeInsets.symmetric(
                              horizontal: 20, vertical: 20),
                          floatingLabelBehavior: FloatingLabelBehavior.always,
                          prefix: SizedBox(
                            width: 10,
                          ),
                          border: OutlineInputBorder(),
                          labelText: "Price",
                          hintText: "Enter Price",
                        ),
                      ),
                      const SizedBox(height: 20),
                      TextFormField(
                        controller: oldPrice,
                        keyboardType: TextInputType.phone,
                        validator:
                            RequiredValidator(errorText: "Price required"),
                        decoration: const InputDecoration(
                          contentPadding: EdgeInsets.symmetric(
                              horizontal: 20, vertical: 20),
                          floatingLabelBehavior: FloatingLabelBehavior.always,
                          prefix: SizedBox(
                            width: 10,
                          ),
                          border: OutlineInputBorder(),
                          labelText: "Price Price",
                          hintText: "Enter Previous Price ",
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      isloading
                          ? const Center(child: CircularProgressIndicator())
                          : SizedBox(
                              width: double.infinity,
                              height: 46,
                              child: TextButton(
                                style: TextButton.styleFrom(
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(24)),
                                  primary: Colors.white,
                                  backgroundColor: const Color(0xFF4167b2),
                                ),
                                onPressed: () {
                                  final isvalid =
                                      _formKey.currentState!.validate();
                                  if (isvalid) {
                                    submit();
                                  } else {}
                                  // login();
                                },
                                child: const Text(
                                  "Submit",
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w700,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                      const SizedBox(height: 70),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
