import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ubixstar/Screens/home_page.dart';
import 'package:ubixstar/Widget/selection_box.dart';

import '../Widget/screen_change_buttons.dart';

class WidgetSelect extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return widgetSelect();
  }
}
class widgetSelect extends State<WidgetSelect>{
  bool isTextWidget = false;
  bool isImageWidget = false;
  bool isButtonWidget = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.green.shade50,
        child: Center(
          child: Padding(
            padding: EdgeInsets.only(top: 200.h),
            child: Column(
              children: [
                SelectionBox(
                  widgetName: "Text Widget",
                  isSelected: isTextWidget,
                  onTap: (){
                    setState(() {
                      isTextWidget =! isTextWidget;
                    });
                  },
                ),
                SizedBox(height: 50.h,),
                SelectionBox(
                  widgetName: "Image Widget",
                  isSelected: isImageWidget,
                  onTap: (){
                    setState(() {
                      isImageWidget =! isImageWidget;
                    });
                  },
                ),

                SizedBox(height: 50.h,),

                SelectionBox(
                  isSelected: isButtonWidget,
                  widgetName: "Button Widget",
                  onTap: (){
                    setState(() {
                      isButtonWidget =! isButtonWidget;
                    });
                  },
                ),
                SizedBox(height: 200.h,),
                PageChangeButton(
                  name: "Import Widget",
                  onTap: (){
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context)=>MyHomePage(
                              firstWidget: isTextWidget,
                              secondWidget: isImageWidget,
                              thirdWidget: isButtonWidget,
                            )
                        )
                    );
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

}