import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:ubixstar/Screens/widget_selection.dart';
import 'package:ubixstar/Widget/screen_change_buttons.dart';

class MyHomePage extends StatefulWidget{
  final bool? firstWidget;
  final bool? thirdWidget;
  final bool? secondWidget;

  const MyHomePage({
    super.key,
    required this.firstWidget,
    required this.secondWidget,
    required this.thirdWidget
  });

  @override
  State<StatefulWidget> createState() {
    return homepage();
  }
}

class homepage extends State<MyHomePage>{
  late bool val = (widget.firstWidget! || widget.secondWidget! || widget.thirdWidget!);
  File? uploadedFile;
  String? imageUrl;
  TextEditingController controller = TextEditingController();
  late bool onlySave = (widget.thirdWidget == true && widget.firstWidget !=true && widget.secondWidget != true);
  bool msg = false;
  bool showText = false;
  String? storedText;

  Future<void> saveData(String inputText) async {
    try {
      await FirebaseFirestore.instance.collection('textData').add({
        'text': inputText,
        'timestamp': FieldValue.serverTimestamp(),
      });
      final snapshot = await FirebaseFirestore.instance
          .collection('textData')
          .orderBy('timestamp', descending: true)
          .limit(1)
          .get();

      if (snapshot.docs.isNotEmpty) {
        setState(() {
          storedText = snapshot.docs.first['text'];
          showText = true;
        });
      }
    } catch (e) {
      print("Error $e");
    }
  }

  @override
  void initState(){
    super.initState();
  }

  Future<void> uploadImage() async {
    try {
      final ImagePicker imagePicker = ImagePicker();
      final XFile? image = await imagePicker.pickImage(source: ImageSource.gallery);
      if (image != null) {
        File imageFile = File(image.path);

        DateTime.now().millisecondsSinceEpoch.toString();
        // final Reference firebaseStorageRef = FirebaseStorage.instance.ref().child("upload/$fileName.jpg");
        // final UploadTask uploadTask = firebaseStorageRef.putFile(imageFile);
        // final TaskSnapshot snapshot = await uploadTask;
        // ImageFile = await snapshot.ref.getDownloadURL();
        setState(() {
          uploadedFile = imageFile;
        });
      } else {
        print("No image selected");
      }
    } catch (e) {
      print("Error uploading image: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Padding(
                  padding: EdgeInsets.only(top :12.h,bottom: 12.h),
                  child: Center(
                    child: Text(
                          "Assignment App",
                        style: TextStyle(fontSize: 24.sp),
                      ),
                  ),
                ),
                SizedBox(height: 5.h,),

                //Main Container With all the widgets
                val ? Container(
                  height: 600.h,
                  width: 300.w,
                  decoration: BoxDecoration(
                    color: Colors.green.shade50,
                    borderRadius: BorderRadius.circular(12.w),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // Text Widget For Entering the text
                      if (widget.firstWidget == true)
                        Container(
                          height: 50.h,
                          width: 250.w,
                          color: Colors.grey.shade400,
                          child: showText
                              ? Padding(
                            padding: EdgeInsets.only(top: 8.h, left: 20.w),
                            child: Text(
                              storedText ?? "No Text",
                              style: TextStyle(fontSize: 14.sp),
                            ),
                          )
                              : Padding(
                            padding: EdgeInsets.only(top: 5.h, left: 20.w),
                            child: TextField(
                              controller: controller,
                              decoration: const InputDecoration(
                                hintText: "Enter Text",
                                border: InputBorder.none,
                              ),
                              style: TextStyle(fontSize: 14.sp),
                            ),
                          ),
                        ),

                      //Image Container
                      if (widget.secondWidget == true)
                        Padding(
                          padding: EdgeInsets.only(top: 40.h),
                          child: InkWell(
                            onTap: () {
                              uploadImage();
                            },
                            child: Container(
                              height: 220.h,
                              width: 250.w,
                              color: Colors.grey.shade400,
                              child: uploadedFile != null
                                  ? Image.file(
                                  uploadedFile!,
                                  fit: BoxFit.cover)
                                  : Center(
                                child: Text(
                                  "Upload Image",
                                  style: TextStyle(fontSize: 14.sp),
                                ),
                              ),
                            ),
                          ),
                        ),

                      //Save button
                      if(widget.thirdWidget == true)
                        onlySave?
                            //If Only save button is their
                         Column(
                           children: [
                             Container(
                               child: msg?
                               Text("Add atleast one widget",
                               style: TextStyle(
                                 fontSize: 14.sp
                               ),):
                               const Text(""),
                             ),
                             Padding(
                                 padding: EdgeInsets.only(top: 120.h),
                               child: InkWell(
                                 onTap: (){
                                   setState(() {
                                     msg = !msg;
                                   });
                                 },
                                 child: Container(
                                   height: 40.h,
                                   width: 60.w,
                                   decoration: BoxDecoration(
                                     border: Border.all(color: Colors.green.shade900),
                                     color: Colors.greenAccent.shade100,
                                   ),
                                   child: Center(
                                     child: Text("Save", style: TextStyle(fontSize: 14.sp)),
                                   ),
                                 ),
                               ),
                             ),
                           ],
                         )

                            //If all widgets are present
                            :Padding(
                          padding: EdgeInsets.only(top: 60.h),
                          child: InkWell(
                            onTap: () {
                              saveData(controller.text);
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content:
                                  const Text('Saved Successfully',
                                      textAlign: TextAlign.center,
                                  style: TextStyle(color: Colors.black),),
                                  backgroundColor: Colors.green.shade50.withOpacity(0.8),
                                  duration: const Duration(seconds: 2),
                                ),
                              );
                            },
                            child: Container(
                              height: 40.h,
                              width: 60.w,
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.green.shade900),
                                color: Colors.greenAccent.shade100,
                              ),
                              child: Center(
                                child: Text("Save", style: TextStyle(fontSize: 14.sp)),
                              ),
                            ),
                          ),
                        ),
                    ],
                  ),
                )

                //If no widget is selected
                    : Container(
                  height: 600.h,
                  width: 300.w,
                  decoration: BoxDecoration(
                    color: Colors.green.shade50,
                    borderRadius: BorderRadius.circular(12.w),
                  ),
                  child: Center(
                    child: Text(
                      "No Widget is Added",
                      style: TextStyle(fontSize: 24.sp),
                    ),
                  ),
                ),
                SizedBox(height: 5.h,),
            
                //Add Widget Button
                Padding(
                  padding: EdgeInsets.only(top: 12.h),
                  child: PageChangeButton(
                    name: "Add Widget",
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>WidgetSelect()));
                    },
                  ),
                )
              ],
            ),
          ) ),
    );
  }
}