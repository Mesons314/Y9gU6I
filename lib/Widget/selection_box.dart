
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SelectionBox extends StatefulWidget{
  final bool? isSelected;
  final String? widgetName;
  final VoidCallback? onTap;

  const SelectionBox({super.key,this.isSelected,this.onTap,this.widgetName});

  @override
  State<StatefulWidget> createState() {
    return selectionBox();
  }
}

class selectionBox extends State<SelectionBox>{
  @override
  Widget build(BuildContext context) {
    return Stack(
        children: [
          Container(
            height: 40.h,
            width: 220.w,
            color: Colors.grey.shade400,
            child: Row(
              children: [
                Container(
                  height: 40.h,
                  width: 40.h,
                  color: Colors.white,
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: InkWell(
                      onTap: widget.onTap,
                      child: Container(
                        height: 5.h,
                        width: 5.w,
                        decoration: BoxDecoration(
                            color: widget.isSelected! ? Colors.green : Colors.grey,
                            shape: BoxShape.circle
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Positioned(
              left: 60.w,
              top: 10.h,
              child: Text(
                widget.widgetName!,
                style: TextStyle(fontSize: 12.sp),
              )
          )
        ]
    );
  }

}